<?php

namespace Ryanwhowe\Tools\Util;

use ReflectionClass;
use ReflectionException;
use Symfony\Component\Console\Application as BaseApplication;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\DependencyInjection\ContainerAwareInterface;
use Symfony\Component\Finder\Finder;

class Application extends BaseApplication {

    const LOGO = '    ___                 ______                       __
   /   |  _  _____     / ____/___  ____  _________  / /__
  / /| | | |/_/ _ \   / /   / __ \/ __ \/ ___/ __ \/ / _ \
 / ___ |_>  </  __/  / /___/ /_/ / / / (__  ) /_/ / /  __/
/_/  |_/_/|_|\___/   \____/\____/_/ /_/____/\____/_/\___/';

    const TAG_LINE = 'Let\'s Get Sh*t Done!!';
    const NAME = 'Axe Console';

    const VERSION = '1.1.3';


    private $commandsRegistered = false;

    /**
     * @throws ReflectionException
     */
    public function __construct() {
        parent::__construct(self::NAME, self::VERSION);
        
        $this->registerCommands();
    }

    public function getKernel(): KernelInterface {
        return $this->kernel;
    }

    public function getLongVersion(): string {
        return sprintf('<fg=red>%s</>

  - <fg=red>%s</>
  
<fg=yellow>%s</>
version: <info>%s</info>', self::LOGO, self::TAG_LINE, $this->getName(), $this->getVersion());
    }


    /**
     * Dynamically register all commands in the Command folder
     *
     * @return void
     * @throws ReflectionException
     */
    protected function registerCommands()
    {
        if (!is_dir($dir = __DIR__ . '/../Command')) return;

        $finder = new Finder();
        $finder->files()->name('*Command.php')->in($dir);

        $prefix = 'Ryanwhowe\\Tools\\Command';
        foreach ($finder as $file) {
            $ns = $prefix;
            if ($relativePath = $file->getRelativePath()) {
                $ns = $prefix . '\\'.strtr($relativePath, '/', '\\');
            }
            $r = new ReflectionClass($ns.'\\'.$file->getBasename('.php'));
            if ($r->isSubclassOf(Command::class) && !$r->isAbstract()) {
                $this->add($r->newInstance());
            }
        }
    }
}