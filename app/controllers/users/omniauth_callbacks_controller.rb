class Users::OmniauthCallbacksController < ApplicationController
    # Modulo::clase
    #Accion se llama Facebook
    def facebook
        #Mandamos llamar el metodo que creamos y le neviamos los parametros que nos regreso omniauth
        @user = User.from_omniauth(request.env["omniauth.auth"])
        #@user.persisted? regresa true si el objeto esta guardado en la db y falso si el objeto aun no esta en la db 
        if  @user.persisted?
            @user.remember_me = true
            #el metodo sign_in_and_redirect es algo que ya viene incluido en la gema devise
            sign_in_and_redirect @user, event: :authentication
            return 
            # cuando el user ya esta creado ya no continuan las lineas de abajo
        end
        #guardamos la info que nos regreso omniaout para poder verla en otros metodos
        session["devise:outh"] = request.env["omniauth.auth"]
        #llama a mi vista edit
        render :edit
    end
    def custom_sign_up
        @user = User.from_omniauth(session["devise.auth"])
        #strong params
        #Cuando se actualiza un registro los parametros siempre tiene que ir sanitizados (strong params)
        if @user.update(user_params)
            sign_in_and_redirect @user, event: :authentication
        else
            render :edit
        end
    end
    
    def failure
        redirect_to new_user_session_path, notice:"Error: #{params[:error_description]}. Reason: #{params[:error_reason]}"
    end


    #todos los metodos privados deben de ir debajo de el keyword private 
    private
    def user_params
        #Strong params
        #No me habia dado cuenta lo facil que seria inyectar algun campo dentro de un form 
        #En rails para evitar eso se crean strong params
        params.required(:user).permit(:name,:username,:email)
    end

end