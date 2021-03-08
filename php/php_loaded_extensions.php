
    <?php
    $loaded_extensions = get_loaded_extensions();
    echo 'Total loaded extensions: ', count($loaded_extensions), "\n";

    foreach (array_chunk($loaded_extensions, 4) as $extensionx4) {
        foreach ($extensionx4 as $extension) {
            echo '- ' . str_pad($extension, 18, ' ', STR_PAD_RIGHT);
        }
        echo "\n";
    }
