class PostconfirmMailer < ApplicationMailer
  def postconfirm_mail(postconfirm)
    @postconfirm = postconfirm

    mail to: @postconfirm.user.email, subject: "写真投稿完了の確認メール"
  end
end
