# frozen_string_literal: true

# このモジュールをincludeすることで、includeしたインスタンス自身のdestroyを出来なくさせる。
# これは1対1のリレーションにおいて、親子が必ず存在しなければならない際に、子のみの削除を防止する。
module EnsureDestroyedByAssociation
  extend ActiveSupport::Concern

  included do
    before_destroy do
      # destroyed_by_associationはdependent: :destroyなどの関連付けによる削除が発生した場合はtrueを返し、
      # 自分自身で削除した場合はfalseを返す。
      unless destroyed_by_association
        errors.add(:base, 'このモデルのみを削除することはできません。削除する場合は、親を削除してください。')
        throw(:abort)
      end
    end
  end
end
