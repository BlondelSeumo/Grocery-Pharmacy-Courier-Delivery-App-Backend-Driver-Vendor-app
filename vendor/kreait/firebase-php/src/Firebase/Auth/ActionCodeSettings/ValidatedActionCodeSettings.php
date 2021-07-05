<?php

declare(strict_types=1);

namespace Kreait\Firebase\Auth\ActionCodeSettings;

use GuzzleHttp\Psr7\Utils;
use Kreait\Firebase\Auth\ActionCodeSettings;
use Kreait\Firebase\Exception\InvalidArgumentException;
use Psr\Http\Message\UriInterface;

final class ValidatedActionCodeSettings implements ActionCodeSettings
{
    /** @var UriInterface|null */
    private $continueUrl;

    /** @var bool|null */
    private $canHandleCodeInApp;

    /** @var UriInterface|null */
    private $dynamicLinkDomain;

    /** @var string|null */
    private $androidPackageName;

    /** @var string|null */
    private $androidMinimumVersion;

    /** @var bool|null */
    private $androidInstallApp;

    /** @var string|null */
    private $iOSBundleId;

    private function __construct()
    {
    }

    public static function empty(): self
    {
        return new self();
    }

    /**
     * @param array<string, mixed> $settings
     */
    public static function fromArray(array $settings): self
    {
        $instance = new self();

        $settings = \array_filter($settings, static function ($value) {
            return $value !== null;
        });

        foreach ($settings as $key => $value) {
            switch (\mb_strtolower($key)) {
                case 'continueurl':
                case 'url':
                    $instance->continueUrl = Utils::uriFor($value);
                    break;
                case 'handlecodeinapp':
                    $instance->canHandleCodeInApp = (bool) $value;
                    break;
                case 'dynamiclinkdomain':
                    $instance->dynamicLinkDomain = Utils::uriFor($value);
                    break;
                case 'androidpackagename':
                    $instance->androidPackageName = (string) $value;
                    break;
                case 'androidminimumversion':
                    $instance->androidMinimumVersion = (string) $value;
                    break;
                case 'androidinstallapp':
                    $instance->androidInstallApp = (bool) $value;
                    break;
                case 'iosbundleid':
                    $instance->iOSBundleId = (string) $value;
                    break;
                default:
                    throw new InvalidArgumentException("Unsupported action code setting '{$key}'");
            }
        }

        return $instance;
    }

    /**
     * @return array<string, string|bool>
     */
    public function toArray(): array
    {
        return \array_filter([
            'continueUrl' => $this->continueUrl ? (string) $this->continueUrl : null,
            'canHandleCodeInApp' => $this->canHandleCodeInApp,
            'dynamicLinkDomain' => $this->dynamicLinkDomain ? (string) $this->dynamicLinkDomain : null,
            'androidPackageName' => $this->androidPackageName,
            'androidMinimumVersion' => $this->androidMinimumVersion,
            'androidInstallApp' => $this->androidInstallApp,
            'iOSBundleId' => $this->iOSBundleId,
        ], static function ($value) {
            return $value !== null;
        });
    }
}
