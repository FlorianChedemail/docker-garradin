{include file="admin/_head.tpl" title="Modification de l'opération n°%d"|args:$operation.id current="compta/saisie" js=1}

{form_errors}

<form method="post" action="{$self_url}">

    <fieldset>
        <legend>Informations sur l'opération</legend>
        <dl>
            <dt><label for="f_date">Date</label> <b title="(Champ obligatoire)">obligatoire</b></dt>
            <dd><input type="date" name="date" id="f_date" value="{form_field name=date default=$operation.date|date_fr:'Y-m-d'}" size="10" required="required" /></dd>
            <dt><label for="f_libelle">Libellé</label> <b title="(Champ obligatoire)">obligatoire</b></dt>
            <dd><input type="text" name="libelle" id="f_libelle" value="{form_field name=libelle data=$operation}" required="required" /></dd>
            <dt><label for="f_montant">Montant</label> <b title="(Champ obligatoire)">obligatoire</b></dt>
            <dd><input type="number" size="5" name="montant" id="f_montant" value="{form_field name=montant data=$operation}" min="0.00" step="0.01" required="required" /> {$config.monnaie}</dd>

{if is_null($type)}
            <dt><label for="f_compte_debit">Compte débité</label> <b title="(Champ obligatoire)">obligatoire</b></dt>
            <dd>
                {select_compte comptes=$comptes name="compte_debit" data=$operation}
            </dd>
            <dt><label for="f_compte_credit">Compte crédité</label> <b title="(Champ obligatoire)">obligatoire</b></dt>
            <dd>
                {select_compte comptes=$comptes name="compte_credit" data=$operation}
            </dd>
{else}
            <dt><label for="f_moyen_paiement">Moyen de paiement</label> <b title="(Champ obligatoire)">obligatoire</b></dt>
            <dd>
                <select name="moyen_paiement" id="f_moyen_paiement">
                {foreach from=$moyens_paiement item="moyen"}
                    <option value="{$moyen.code}"{if $moyen.code == $operation.moyen_paiement} selected="selected"{/if}>{$moyen.nom}</option>
                {/foreach}
                </select>
            </dd>
            <dt class="f_cheque"><label for="f_numero_cheque">Numéro de chèque</label></dt>
            <dd class="f_cheque"><input type="text" name="numero_cheque" id="f_numero_cheque" value="{form_field name=numero_cheque data=$operation}" /></dd>
            <dt class="f_banque"><label for="f_banque">Compte bancaire</label></dt>
            <dd class="f_banque">
                <select name="banque" id="f_banque">
                {foreach from=$comptes_bancaires item="compte"}
                    <option value="{$compte.id}"{if ($type == Garradin\Compta\Categories::DEPENSES && $compte.id == $operation.compte_credit) || $compte.id == $operation.compte_debit} selected="selected"{/if}>{$compte.libelle} - {$compte.banque}</option>
                {/foreach}
                {if ($type == Garradin\Compta\Categories::RECETTES)}
                    <option value="{$id_cheque_a_encaisser}"{form_field name="banque" selected=$id_cheque_a_encaisser default=$operation.compte_debit}>Chèques à encaisser</option>
                    <option value="{$id_carte_a_encaisser}"{form_field name="banque" selected=$id_carte_a_encaisser default=$operation.compte_debit}>Paiement CB à encaisser</option>
                {/if}
                </select>
            </dd>
{/if}

            <dt><label for="f_numero_piece">Numéro de pièce comptable</label></dt>
            <dd><input type="text" name="numero_piece" id="f_numero_piece" value="{form_field name=numero_piece data=$operation}" /></dd>
            <dt><label for="f_remarques">Remarques</label></dt>
            <dd><textarea name="remarques" id="f_remarques" rows="4" cols="30">{form_field name=remarques data=$operation}</textarea></dd>

            {if count($projets) > 0}
            <dt><label for="f_projet">Projet</label></dt>
            <dd>
                <select name="id_projet" id="f_projet">
                    <option value="0">-- Aucun</option>
                    {foreach from=$projets key="id" item="libelle"}
                        <option value="{$id}"{form_field name="id_projet" selected=$id data=$operation}>{$libelle}</option>
                    {/foreach}
                </select>
            </dd>
            {/if}

        </dl>
    </fieldset>

{if !is_null($type)}
    <fieldset>
        <legend>Catégorie</legend>
        <dl class="catList">
        {foreach from=$categories item="cat"}
            <dt>
                <input type="radio" name="id_categorie" value="{$cat.id}" id="f_cat_{$cat.id}" {form_field name="id_categorie" checked=$cat.id data=$operation} />
                <label for="f_cat_{$cat.id}">{$cat.intitule}</label>
            </dt>
            {if !empty($cat.description)}
                <dd class="desc">{$cat.description}</dd>
            {/if}
        {/foreach}
        </dl>
    </fieldset>

    <script type="text/javascript">
    {literal}
    (function () {

        window.changeMoyenPaiement = function()
        {
            var elm = $('#f_moyen_paiement');
            g.toggle('.f_cheque', elm.value == 'CH');
            g.toggle('.f_banque', elm.value != 'ES');
        };

        changeMoyenPaiement();

        $('#f_moyen_paiement').onchange = changeMoyenPaiement;
    } ());
    {/literal}
    </script>
{/if}

    <p class="submit">
        {csrf_field key="compta_modifier_%d"|args:$operation.id}
        <input type="submit" name="save" value="Enregistrer &rarr;" />
    </p>

</form>

{include file="admin/_foot.tpl"}