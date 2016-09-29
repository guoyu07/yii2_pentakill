<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "ms_news".
 *
 * @property string $news_id
 * @property string $cat_id
 * @property string $title
 * @property string $code
 * @property string $intro
 * @property string $keywords
 * @property string $image_url
 * @property string $source
 * @property integer $display
 * @property integer $status
 * @property integer $listorder
 * @property string $hits
 * @property string $created_by
 * @property string $created_time
 * @property string $modified_by
 * @property string $modified_time
 */
class News extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'ms_news';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['cat_id', 'title', 'code', 'intro', 'created_by', 'created_time'], 'required'],
            [['cat_id', 'display', 'status', 'listorder', 'hits', 'created_by', 'created_time', 'modified_by', 'modified_time'], 'integer'],
            [['title', 'keywords'], 'string', 'max' => 50],
            [['code', 'source'], 'string', 'max' => 20],
            [['intro'], 'string', 'max' => 250],
            [['image_url'], 'string', 'max' => 100],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'news_id' => 'News ID',
            'cat_id' => 'Cat ID',
            'title' => 'Title',
            'code' => 'Code',
            'intro' => 'Intro',
            'keywords' => 'Keywords',
            'image_url' => 'Image Url',
            'source' => 'Source',
            'display' => 'Display',
            'status' => 'Status',
            'listorder' => 'Listorder',
            'hits' => 'Hits',
            'created_by' => 'Created By',
            'created_time' => 'Created Time',
            'modified_by' => 'Modified By',
            'modified_time' => 'Modified Time',
        ];
    }
}
