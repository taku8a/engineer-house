class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    # if @contact.invalid?
    #   render :new
    # end
  end

  def back
    @contact = Contact.new(contact_params)
    render :new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver  #メール送信処理追加
      ContactMailer.received_mail(@contact).deliver
      redirect_to complete_contacts_path, notice: t("notice.send_chat")
    else
      render :new
    end
  end

  def complete
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end

end
