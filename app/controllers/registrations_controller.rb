class RegistrationsController < Devise::RegistrationsController

    protected
    def new
        super
    end

    def create
        super
    end

    def update
        respond_to do |format|
            if @user.update(user_params)
              format.html { redirect_to @user, notice: 'User was successfully updated.' }
              format.json { render :show, status: :ok, location: @user }
            else
              format.html { render :edit }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
          end
    end
    def user_params
        params.require(:tweet).permit(:post)
      end
  
end


    
