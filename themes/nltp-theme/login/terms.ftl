<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        ${msg("termsTitle")}
    <#elseif section = "form">
    <div id="kc-terms-text">
    I accept these  <a href="${properties.termsUrl}" target="_blank">Terms of Service</a> and <a href="${properties.privacyUrl}" target="_blank">Privacy Policy</a>
     </div>
    <form class="form-actions" action="${url.loginAction}" method="POST">
        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" name="accept" id="kc-accept" type="submit" value="${msg("doAccept")}"/>
        <input class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" name="cancel" id="kc-decline" type="submit" value="${msg("doDecline")}"/>
    </form>
    <div class="clearfix"></div>
    </#if>
</@layout.registrationLayout>
