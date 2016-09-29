<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "ms_link".
 *
 * @property string $link_id
 * @property string $link_name
 * @property string $link_url
 * @property string $cat_id
 * @property string $image_url
 * @property integer $display
 * @property integer $status
 * @property integer $listorder
 * @property string $hits
 * @property string $created_by
 * @property string $created_time
 * @property string $modified_by
 * @property string $modified_time
 */
class Link extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'ms_link';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['link_name', 'link_url', 'cat_id', 'created_by', 'created_time'], 'required'],
            [['cat_id', 'display', 'status', 'listorder', 'hits', 'created_by', 'created_time', 'modified_by', 'modified_time'], 'integer'],
            [['link_name'], 'string', 'max' => 50],
            [['link_url', 'image_url'], 'string', 'max' => 100],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'link_id' => 'Link ID',
            'link_name' => 'Link Name',
            'link_url' => 'Link Url',
            'cat_id' => 'Cat ID',
            'image_url' => 'Image Url',
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
