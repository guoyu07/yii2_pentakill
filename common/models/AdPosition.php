<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "ms_ad_position".
 *
 * @property string $pos_id
 * @property string $pos_name
 * @property string $pos_code
 * @property integer $pos_ad_count
 * @property integer $status
 * @property string $created_by
 * @property string $created_time
 * @property string $modified_by
 * @property string $modified_time
 */
class AdPosition extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'ms_ad_position';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['pos_name', 'pos_code', 'pos_ad_count', 'status', 'created_by', 'created_time'], 'required'],
            [['pos_ad_count', 'status', 'created_by', 'created_time', 'modified_by', 'modified_time'], 'integer'],
            [['pos_name', 'pos_code'], 'string', 'max' => 50],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'pos_id' => 'Pos ID',
            'pos_name' => 'Pos Name',
            'pos_code' => 'Pos Code',
            'pos_ad_count' => 'Pos Ad Count',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_time' => 'Created Time',
            'modified_by' => 'Modified By',
            'modified_time' => 'Modified Time',
        ];
    }
}
