<?php /** @noinspection PhpUnused */

namespace Ryanwhowe\Tools\Command;

use Exception;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

class SortFileCommand extends Command {

    protected static string $defaultName = 'util:file:sort';
    protected static string $defaultDescription = 'Sort the contexts of a file, line by line and write the sorted output to a new file';
    private SymfonyStyle $io;

    protected function configure() {
        $this
            ->setName(self::$defaultName)
            ->setDescription(self::$defaultDescription)
            ->addArgument('input', InputArgument::REQUIRED, 'Source file to parse')
            ->addArgument('output', InputArgument::REQUIRED, 'The sorted output file');
    }

    protected function execute(InputInterface $input, OutputInterface $output): int {
        $this->io = new SymfonyStyle($input, $output);
        $inputFile = $input->getArgument('input');
        $outputFile = $input->getArgument('output');

        try {
            $inputContents = $this->getInputFile($inputFile);
        } catch (Exception $e) {
            $this->io->error($e->getMessage());
            return self::FAILURE;
        }

        sort($inputContents);

        $new = !file_exists($outputFile);
        if ($new) {
            $mode = 'w+';
        } else {
            $mode = 'a+';
        }
        $resource = fopen($outputFile, $mode);

        array_walk($inputContents, function($line) use ($resource): void {
            fwrite($resource, $line);
        });

        if(is_resource($resource))  {
            fclose($resource);
        }

        return self::SUCCESS;
    }


    /**
     * @param $filename
     *
     * @return array
     * @throws Exception
     */
    protected function getInputFile($filename): array {
        $contents = file($filename);
        if (false === $contents) {
            throw new Exception('Unable To Open file ' . $filename);
        }
        return $contents;
    }
}