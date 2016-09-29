<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "ms_category".
 *
 * @property string $cat_id
 * @property string $cat_name
 * @property integer $cat_type
 * @property string $parentid
 * @property integer $lv
 * @property string $cat_code
 * @property integer $is_out_url
 * @property string $out_url
 * @property integer $display
 * @property integer $status
 * @property integer $listorder
 * @property string $modified_by
 * @property string $modified_time
 * @property string $created_time
 * @property string $created_by
 */
class Category extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'ms_category';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['cat_name', 'cat_type', 'lv', 'cat_code', 'created_time', 'created_by'], 'required'],
            [['cat_type', 'parentid', 'lv', 'is_out_url', 'display', 'status', 'listorder', 'modified_by', 'modified_time', 'created_time', 'created_by'], 'integer'],
            [['cat_name', 'cat_code'], 'string', 'max' => 50],
            [['out_url'], 'string', 'max' => 255],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'cat_id' => 'Cat ID',
            'cat_name' => 'Cat Name',
            'cat_type' => 'Cat Type',
            'parentid' => 'Parentid',
            'lv' => 'Lv',
            'cat_code' => 'Cat Code',
            'is_out_url' => 'Is Out Url',
            'out_url' => 'Out Url',
            'display' => 'Display',
            'status' => 'Status',
            'listorder' => 'Listorder',
            'modified_by' => 'Modified By',
            'modified_time' => 'Modified Time',
            'created_time' => 'Created Time',
            'created_by' => 'Created By',
        ];
    }
}
