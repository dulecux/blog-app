class ArticleMailer < ApplicationMailer
	default from: 'notifications@example.com'

	def created_article
       @article = params[:article]
       mail(to: @article.author.email, subject: 'Your Article is Created!')
    end

    def updated_article
       @article = params[:article]
       mail(to: @article.author.email, subject: 'Your Article Status is Updated!')
    end	
end
