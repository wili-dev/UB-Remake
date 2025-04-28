#include <a_http>

Mailer_SendEmail(const template_type[], const user_email[], const user_name[], const user_code[])
{
    new
        url[250];

    format(url, _, "localhost/ub-forgot-password/index.php?template-type=%s&user-email=%s&user-name=%s&user-code=%s",
    template_type, user_email, user_name, user_code);

    for (new c = 0; c < strlen(url) + 1; c++) {
         if (url[c] == ' ') url[c] = '+';
    }

    HTTP(0, HTTP_POST, url, "", "OnSendEmailResponse");
    return 1;
}

forward OnSendEmailResponse(index, response_code, data[]);
public OnSendEmailResponse(index, response_code, data[])
{
    if (response_code != 200) {

        printf("[ERROR] Falha ao tentar enviar e-mail. Codigo: %d", response_code);
    }
    return 1;
}