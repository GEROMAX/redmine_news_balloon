require_dependency("application_helper")
 
module NewsBalloonApplicationHelperPatch
  def self.included(base)
    base.send(:include, InstanceMethod)
 
    base.class_eval do
      ###########################
      # alias_method で ApplicationHelper にメソッドを追加
      alias_method :has_news_since_last_login_on?, :def_has_news_since_last_login_on?
      alias_method :count_news_since_last_login_on, :def_count_news_since_last_login_on
    end
  end
 
  module InstanceMethod
    # 最後のログインから作られたニュースがあるか
    def def_has_news_since_last_login_on?
      return News.exists?(["created_on > ? and project_id in (?)", User.current.last_before_access_on, Project.visible.collect(&:id)])
    end

    # 最後のログインから作られたニュースの数を取得する
    def def_count_news_since_last_login_on
      return News.where("created_on > ? and project_id in (?)", User.current.last_before_access_on, Project.visible.collect(&:id)).count
      #return News.count(:conditions => ["created_on > ? and project_id in (?)", User.current.last_before_access_on, Project.visible.collect(&:id)])
    end
  end
end
 
# ApplicationHelper モジュールに NewsBalloonApplicationHelperPatch を
# インクルードさせる。
ApplicationHelper.send(:include, NewsBalloonApplicationHelperPatch)