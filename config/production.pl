+{
    'DBI' => [
        "dbi:SQLite:dbname=$ENV{HOME}/production.db",
        '',
        '',
        +{
            sqlite_unicode => 1,
        }
    ],
    'Text::Xslate' => +{
    },
};
