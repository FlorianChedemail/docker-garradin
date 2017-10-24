{include file="admin/_head.tpl" title="Cotisations" current="membres/cotisations" js=1}

<ul class="actions">
    <li class="current"><a href="{$admin_url}membres/cotisations/">Cotisations</a></li>
    <li><a href="{$admin_url}membres/cotisations/ajout.php">Saisie d'une cotisation</a></li>
    {if $session->canAccess('membres', Garradin\Membres::DROIT_ADMIN)}
        <li><a href="{$admin_url}membres/cotisations/gestion/rappels.php">Gestion des rappels automatiques</a></li>
    {/if}
</ul>

<table class="list">
    <thead>
        <th>Cotisation</th>
        <td>Période</td>
        <td>Montant</td>
        <td>Membres inscrits</td>
        <td>Membres à jour</td>
        <td></td>
    </thead>
    <tbody>
        {foreach from=$liste item="co"}
            <tr>
                <th><a href="{$admin_url}membres/cotisations/voir.php?id={$co.id}">{$co.intitule}</a></th>
                <td>
                    {if $co.duree}
                        {$co.duree} jours
                    {elseif $co.debut}
                        du {$co.debut|format_sqlite_date_to_french} au {$co.fin|format_sqlite_date_to_french}
                    {else}
                        ponctuelle
                    {/if}
                </td>
                <td class="num">{$co.montant|escape|html_money} {$config.monnaie}</td>
                <td class="num">{$co.nb_membres}</td>
                <td class="num">{$co.nb_a_jour}</td>
                <td class="actions">
                    <a class="icn" href="{$admin_url}membres/cotisations/voir.php?id={$co.id}" title="Liste des membres cotisants">👪</a>
                    {if $session->canAccess('membres', Garradin\Membres::DROIT_ADMIN)}
                        <a class="icn" href="{$admin_url}membres/cotisations/gestion/modifier.php?id={$co.id}" title="Modifier">✎</a>
                        <a class="icn" href="{$admin_url}membres/cotisations/gestion/supprimer.php?id={$co.id}" title="Supprimer">✘</a>
                    {/if}
                </td>
            </tr>
        {/foreach}
    </tbody>
</table>

{if $session->canAccess('membres', Garradin\Membres::DROIT_ADMIN)}

{form_errors}

<p class="help">
    Idée : les cotisations peuvent également être utilisées pour suivre les activités auxquelles
    sont inscrits les membres de l'association.
</p>

<form method="post" action="{$self_url}" id="f_add">

    <fieldset>
        <legend>Ajouter une cotisation</legend>
        <dl>
            <dt><label for="f_intitule">Intitulé</label> <b title="(Champ obligatoire)">obligatoire</b></dt>
            <dd><input type="text" name="intitule" id="f_intitule" value="{form_field name=intitule}" required="required" /></dd>
            <dt><label for="f_description">Description</label></dt>
            <dd><textarea name="description" id="f_description" cols="50" rows="3">{form_field name=description}</textarea></dd>
            <dt><label for="f_montant">Montant minimal</label> <b title="(Champ obligatoire)">obligatoire</b></dt>
            <dd class="help">Laisser à <b>0</b> pour une cotisation à prix libre</dd>
            <dd><input type="number" name="montant" step="0.01" min="0.00" id="f_montant" value="{form_field name=montant default=0.00}" required="required" /></dd>

            <dt><label for="f_periodicite_jours">Période de validité</label></dt>
            <dd><input type="radio" name="periodicite" id="f_periodicite_ponctuel" value="ponctuel" {form_field checked="ponctuel" name=periodicite default="ponctuel"} /> <label for="f_periodicite_ponctuel">Pas de période (cotisation ponctuelle)</label></dd>

            <dd><input type="radio" name="periodicite" id="f_periodicite_jours" value="jours" {form_field checked="jours" name=periodicite} /> <label for="f_periodicite_jours">En nombre de jours</label>
                <dl class="periode_jours">
                    <dt><label for="f_duree">Durée de validité</label> <b title="(Champ obligatoire)">obligatoire</b></dt>
                    <dd><input type="number" step="1" size="5" min="1" name="duree" id="f_duree" value="{form_field name="duree"}" /></dd>
                </dl>
            </dd>
            <dd><input type="radio" name="periodicite" id="f_periodicite_dates" value="date" {form_field checked="date" name=periodicite} /> <label for="f_periodicite_dates">Période définie</label>
                <dl class="periode_dates">
                    <dt><label for="f_date_debut">Date de début</label> <b title="(Champ obligatoire)">obligatoire</b></dt>
                    <dd><input type="date" name="debut" value="{form_field name=debut}" id="f_date_debut" /></dd>
                    <dt><label for="f_date_fin">Date de fin</label> <b title="(Champ obligatoire)">obligatoire</b></dt>
                    <dd><input type="date" name="fin" value="{form_field name=fin}" id="f_date_fin" /></dd>
                </dl>
            </dd>
            <dt>
                <input type="checkbox" name="categorie" id="f_categorie" value="1" {form_field name="categorie" checked=1} /> <label for="f_categorie">Enregistrer les cotisations des membres dans la comptabilité</label>
            </dt>
            <dd class="help cat_compta">
                Si coché, à chaque enregistrement de cotisation d'un membre une opération 
                du montant de la cotisation sera enregistrée dans la comptabilité selon
                la catégorie choisie.
            </dd>
            <dt class="cat_compta"><label for="f_id_categorie_compta">Catégorie comptable</label></dt>
            <dd class="cat_compta">
                <select name="id_categorie_compta" id="f_id_categorie_compta">
                {foreach from=$categories item="cat"}
                    <option value="{$cat.id}" {form_field name="id_categorie_compta" selected=$cat.id}>{$cat.intitule}
                    {if !empty($cat.description)}
                        — <em>{$cat.description}</em>
                    {/if}
                    </option>
                {/foreach}
                </select>
            </dd>
        </dl>
    </fieldset>

    <p class="submit">
        {csrf_field key="new_cotisation"}
        <input type="submit" name="save" value="Ajouter &rarr;" />
    </p>

</form>

<script type="text/javascript">
{literal}
(function () {
    var hide = [];

    if (!$('#f_categorie').checked)
        hide.push('.cat_compta');

    if (!$('#f_periodicite_jours').checked)
        hide.push('.periode_jours');

    if (!$('#f_periodicite_dates').checked)
        hide.push('.periode_dates');

    g.toggle(hide, false);

    $('#f_categorie').onchange = function() {
        g.toggle('.cat_compta', this.checked);
        return true;
    };

    function togglePeriode()
    {
        g.toggle(['.periode_jours', '.periode_dates'], false);

        if (this.checked && this.value == 'jours')
            g.toggle('.periode_jours', true);
        else if (this.checked && this.value == 'date')
            g.toggle('.periode_dates', true);
    }

    $('#f_periodicite_ponctuel').onchange = togglePeriode;
    $('#f_periodicite_dates').onchange = togglePeriode;
    $('#f_periodicite_jours').onchange = togglePeriode;
})();
{/literal}
</script>

{/if}

{include file="admin/_foot.tpl"}