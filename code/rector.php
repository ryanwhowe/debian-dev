<?php

declare(strict_types=1);

use Rector\Config\RectorConfig;
use Rector\Caching\ValueObject\Storage\FileCacheStorage;
use Rector\Set\ValueObject\SetList;

return RectorConfig::configure()
    ->withPaths([
        '/root/mounted/',
    ])
    // uncomment to reach your current PHP version
    ->withSets([SetList::PHP_56])
    ->withCache(
    // ensure file system caching is used instead of in-memory
        cacheClass: FileCacheStorage::class,

        // specify a path that works locally as well as on CI job runners
        cacheDirectory: '/tmp/rector'
    )
    ->withTypeCoverageLevel(0)
    ->withDeadCodeLevel(0)
    ->withCodeQualityLevel(0);
