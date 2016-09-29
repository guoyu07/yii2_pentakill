<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "ms_news_data".
 *
 * @property string $news_id
 * @property string $content
 */
class NewsData extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'ms_news_data';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['news_id'], 'required'],
            [['news_id'], 'integer'],
            [['content'], 'string'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'news_id' => 'News ID',
            'content' => 'Content',
        ];
    }
}
