{include file="admin/_head.tpl" title="Comptes bancaires" current="compta/banques"}

<ul class="actions">
    <li class="current"><a href="{$www_url}admin/compta/banques/">Comptes bancaires</a></li>
    <li><a href="{$www_url}admin/compta/comptes/journal.php?id={$id_caisse}&amp;suivi">Journal de caisse</a></li>
    <li><a href="{$www_url}admin/compta/comptes/journal.php?id={$id_cheque_a_encaisser}&amp;suivi">Chèques à encaisser</a></li>
    <li><a href="{$www_url}admin/compta/comptes/journal.php?id={$id_carte_a_encaisser}&amp;suivi">Paiements par carte à encaisser</a></li>
</ul>

{if !empty($liste)}
    <table class="list">
        <thead>
            <tr>
                <td>Banque</td>
                <th>Libellé</th>
                <td>Solde</td>
                <td>IBAN</td>
                <td>BIC</td>
                <td></td>
            </tr>
        </thead>
        <tbody>
        {foreach from=$liste item="compte"}
            <tr>
                <td>{$compte.banque}</td>
                <th>{$compte.libelle}</th>
                <td><strong>{$compte.solde|escape|html_money} {$config.monnaie}</strong></td>
                <td>{$compte.iban|escape|format_iban}</td>
                <td>{$compte.bic}</td>
                <td class="actions">
                    <a class="icn" href="{$www_url}admin/compta/comptes/journal.php?id={$compte.id}&amp;suivi" title="Journal">𝍢</a>
                    {if $session->canAccess('compta', Garradin\Membres::DROIT_ECRITURE)}
                        <a class="icn" href="{$www_url}admin/compta/banques/rapprocher.php?id={$compte.id}" title="Rapprocher">☑</a>
                    {/if}
                    {if $session->canAccess('compta', Garradin\Membres::DROIT_ADMIN)}
                        <a class="icn" href="{$www_url}admin/compta/banques/modifier.php?id={$compte.id}" title="Modifier">✎</a>
                        <a class="icn" href="{$www_url}admin/compta/banques/supprimer.php?id={$compte.id}" title="Supprimer">✘</a>
                    {/if}
                </td>
            </tr>
        {/foreach}
        </tbody>
    </table>
    </dl>
{/if}

{if $session->canAccess('compta', Garradin\Membres::DROIT_ADMIN)}
    {form_errors}

    <form method="post" action="{$self_url}">

        <fieldset>
            <legend>Ajouter un compte bancaire</legend>
            <dl>
                <dt><label for="f_libelle">Libellé</label> <b title="(Champ obligatoire)">obligatoire</b></dt>
                <dd><input type="text" name="libelle" id="f_libelle" value="{form_field name=libelle}" required="required" /></dd>
                <dt><label for="f_banque">Nom de la banque</label> <b title="(Champ obligatoire)">obligatoire</b></dt>
                <dd><input type="text" name="banque" id="f_banque" value="{form_field name=banque}" required="required" /></dd>
                <dt><label for="f_solde">Solde initial</label></dt>
                <dd><input type="number" size="5" name="solde" id="f_solde" value="{form_field name=solde default=0.00}" step="0.01" /> {$config.monnaie}</dd>
                <dt><label for="f_iban">Numéro IBAN</label></dt>
                <dd><input type="text" size="30" name="iban" id="f_iban" value="{form_field name=iban}" /></dd>
                <dt><label for="f_bic">Code BIC/SWIFT de la banque</label></dt>
                <dd><input type="text" size="10" name="bic" id="f_bic" value="{form_field name=bic}" /></dd>
            </dl>
        </fieldset>

        <p class="submit">
            {csrf_field key="compta_ajout_banque"}
            <input type="submit" name="add" value="Enregistrer &rarr;" />
        </p>

    </form>
{/if}
{include file="admin/_foot.tpl"}