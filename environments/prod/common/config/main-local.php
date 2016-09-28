<?php
return [
    'components' => [
        'db' => [
            'class'    => 'yii\db\Connection',
            'dsn'      => 'mysql:host=localhost;port=' . SAE_MYSQL_PORT . ';dbname=' . SAE_MYSQL_DB,
            'username' => SAE_MYSQL_USER,
            'password' => SAE_MYSQL_PASS,
            'charset'  => 'utf8',
        ],
        'mailer' => [
            'class'    => 'yii\swiftmailer\Mailer',
            'viewPath' => '@common/mail',
        ],
    ],
];
