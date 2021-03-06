{include file="admin/_head.tpl" title="Mes informations personnelles" current="mes_infos" js=1}

<ul class="actions">
    <li class="current"><a href="{$admin_url}mes_infos.php">Mes informations personnelles</a></li>
    <li><a href="{$admin_url}mes_infos_securite.php">Mot de passe et options de sécurité</a></li>
</ul>

{form_errors membre=1}

<form method="post" action="{$self_url}">

    <fieldset>
        <legend>Informations personnelles</legend>
        <dl>
            {foreach from=$champs item="champ" key="nom"}
            {if empty($champ.private) && $nom != 'passe'}
                {html_champ_membre config=$champ name=$nom data=$membre user_mode=true}
            {/if}
            {/foreach}
        </dl>
    </fieldset>

    <fieldset>
        <legend>Changer mon mot de passe</legend>
            <p><a href="{$admin_url}mes_infos_securite.php">Modifier mon mot de passe ou autres informations de sécurité.</a></p>
    </fieldset>

    <p class="submit">
        {csrf_field key="edit_me"}
        <input type="submit" name="save" value="Enregistrer &rarr;" />
    </p>

</form>

{include file="admin/_foot.tpl"}