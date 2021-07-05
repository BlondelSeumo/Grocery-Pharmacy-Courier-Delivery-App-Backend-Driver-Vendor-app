<?php

declare(strict_types=1);

namespace Kreait\Firebase;

use GuzzleHttp\ClientInterface;
use InvalidArgumentException;
use Kreait\Firebase\DynamicLink\CreateDynamicLink;
use Kreait\Firebase\DynamicLink\DynamicLinkStatistics;
use Kreait\Firebase\DynamicLink\GetStatisticsForDynamicLink;
use Kreait\Firebase\DynamicLink\ShortenLongDynamicLink;
use Kreait\Firebase\Value\Url;
use Psr\Http\Message\UriInterface;

final class DynamicLinks implements Contract\DynamicLinks
{
    /** @var ClientInterface */
    private $apiClient;

    /** @var Url|null */
    private $defaultDynamicLinksDomain;

    private function __construct(ClientInterface $apiClient)
    {
        $this->apiClient = $apiClient;
    }

    public static function withApiClient(ClientInterface $apiClient): self
    {
        return new self($apiClient);
    }

    /**
     * @param mixed $dynamicLinksDomain
     */
    public static function withApiClientAndDefaultDomain(ClientInterface $apiClient, $dynamicLinksDomain): self
    {
        $domainUrl = Url::fromValue($dynamicLinksDomain);

        $service = self::withApiClient($apiClient);
        $service->defaultDynamicLinksDomain = $domainUrl;

        return $service;
    }

    public function createUnguessableLink($url): DynamicLink
    {
        return $this->createDynamicLink($url, CreateDynamicLink::WITH_UNGUESSABLE_SUFFIX);
    }

    public function createShortLink($url): DynamicLink
    {
        return $this->createDynamicLink($url, CreateDynamicLink::WITH_SHORT_SUFFIX);
    }

    public function createDynamicLink($actionOrParametersOrUrl, ?string $suffixType = null): DynamicLink
    {
        $action = $this->ensureCreateAction($actionOrParametersOrUrl);

        /* @noinspection NotOptimalIfConditionsInspection */
        if (!$action->hasDynamicLinkDomain() && $this->defaultDynamicLinksDomain) {
            $action = $action->withDynamicLinkDomain($this->defaultDynamicLinksDomain);
        }

        if ($suffixType && $suffixType === CreateDynamicLink::WITH_SHORT_SUFFIX) {
            $action = $action->withShortSuffix();
        } elseif ($suffixType && $suffixType === CreateDynamicLink::WITH_UNGUESSABLE_SUFFIX) {
            $action = $action->withUnguessableSuffix();
        }

        return (new CreateDynamicLink\GuzzleApiClientHandler($this->apiClient))->handle($action);
    }

    public function shortenLongDynamicLink($longDynamicLinkOrAction, ?string $suffixType = null): DynamicLink
    {
        $action = $this->ensureShortenAction($longDynamicLinkOrAction);

        if ($suffixType && $suffixType === ShortenLongDynamicLink::WITH_SHORT_SUFFIX) {
            $action = $action->withShortSuffix();
        } elseif ($suffixType && $suffixType === ShortenLongDynamicLink::WITH_UNGUESSABLE_SUFFIX) {
            $action = $action->withUnguessableSuffix();
        }

        return (new ShortenLongDynamicLink\GuzzleApiClientHandler($this->apiClient))->handle($action);
    }

    public function getStatistics($dynamicLinkOrAction, ?int $durationInDays = null): DynamicLinkStatistics
    {
        $action = $this->ensureGetStatisticsAction($dynamicLinkOrAction);

        if ($durationInDays) {
            $action = $action->withDurationInDays($durationInDays);
        }

        return (new DynamicLink\GetStatisticsForDynamicLink\GuzzleApiClientHandler($this->apiClient))->handle($action);
    }

    /**
     * @param mixed $actionOrParametersOrUrl
     */
    private function ensureCreateAction($actionOrParametersOrUrl): CreateDynamicLink
    {
        if ($this->isStringable($actionOrParametersOrUrl)) {
            return CreateDynamicLink::forUrl((string) $actionOrParametersOrUrl);
        }

        if (\is_array($actionOrParametersOrUrl)) {
            return CreateDynamicLink::fromArray($actionOrParametersOrUrl);
        }

        if ($actionOrParametersOrUrl instanceof CreateDynamicLink) {
            return $actionOrParametersOrUrl;
        }

        throw new InvalidArgumentException('Unsupported action');
    }

    /**
     * @param mixed $actionOrParametersOrUrl
     */
    private function ensureShortenAction($actionOrParametersOrUrl): ShortenLongDynamicLink
    {
        if ($this->isStringable($actionOrParametersOrUrl)) {
            return ShortenLongDynamicLink::forLongDynamicLink((string) $actionOrParametersOrUrl);
        }

        if (\is_array($actionOrParametersOrUrl)) {
            return ShortenLongDynamicLink::fromArray($actionOrParametersOrUrl);
        }

        if ($actionOrParametersOrUrl instanceof ShortenLongDynamicLink) {
            return $actionOrParametersOrUrl;
        }

        throw new InvalidArgumentException('Unsupported action');
    }

    /**
     * @param mixed $actionOrUrl
     */
    private function ensureGetStatisticsAction($actionOrUrl): GetStatisticsForDynamicLink
    {
        if ($this->isStringable($actionOrUrl)) {
            return GetStatisticsForDynamicLink::forLink($actionOrUrl);
        }

        if ($actionOrUrl instanceof GetStatisticsForDynamicLink) {
            return $actionOrUrl;
        }

        throw new InvalidArgumentException('Unsupported action');
    }

    /**
     * @param mixed $value
     */
    private function isStringable($value): bool
    {
        return \is_string($value) || $value instanceof UriInterface || (\is_object($value) && \method_exists($value, '__toString'));
    }
}
