<?php

declare(strict_types=1);

namespace Kreait\Firebase\Messaging;

use Kreait\Firebase\Exception\Messaging\InvalidArgument;

final class Topic implements \JsonSerializable
{
    /** @var string */
    private $value;

    private function __construct(string $value)
    {
        $this->value = $value;
    }

    public static function fromValue(string $value): self
    {
        $value = \trim((string) \preg_replace('@^/topic/@', '', $value), '/');

        if (\preg_match('/[^a-zA-Z0-9-_.~]$/', $value)) {
            throw new InvalidArgument(\sprintf('Malformed topic name "%s".', $value));
        }

        return new self($value);
    }

    public function value(): string
    {
        return $this->value;
    }

    public function __toString(): string
    {
        return $this->value;
    }

    public function jsonSerialize(): string
    {
        return $this->value;
    }
}
