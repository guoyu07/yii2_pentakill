<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "ms_ad".
 *
 * @property string $ad_id
 * @property string $ad_name
 * @property string $pos_id
 * @property string $ad_image_url
 * @property string $ad_url
 * @property string $start_time
 * @property string $end_time
 * @property integer $display
 * @property integer $status
 * @property integer $listorder
 * @property string $remark
 * @property string $created_by
 * @property string $created_time
 * @property string $modified_by
 * @property string $modified_time
 */
class Ad extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'ms_ad';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['ad_name', 'pos_id', 'ad_image_url', 'ad_url', 'start_time', 'end_time', 'status', 'created_by', 'created_time'], 'required'],
            [['pos_id', 'start_time', 'end_time', 'display', 'status', 'listorder', 'created_by', 'created_time', 'modified_by', 'modified_time'], 'integer'],
            [['ad_name'], 'string', 'max' => 50],
            [['ad_image_url', 'ad_url'], 'string', 'max' => 100],
            [['remark'], 'string', 'max' => 255],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'ad_id' => 'Ad ID',
            'ad_name' => 'Ad Name',
            'pos_id' => 'Pos ID',
            'ad_image_url' => 'Ad Image Url',
            'ad_url' => 'Ad Url',
            'start_time' => 'Start Time',
            'end_time' => 'End Time',
            'display' => 'Display',
            'status' => 'Status',
            'listorder' => 'Listorder',
            'remark' => 'Remark',
            'created_by' => 'Created By',
            'created_time' => 'Created Time',
            'modified_by' => 'Modified By',
            'modified_time' => 'Modified Time',
        ];
    }
}
