{**
 * authorDetails.tpl
 *
 * Copyright (c) 2000-2009 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Index of published papers by author.
 *
 * $Id$
 *}
{strip}
{assign var="pageTitle" value="search.authorDetails"}
{include file="common/header.tpl"}
{/strip}

<h3>{$lastName|escape}, {$firstName|escape}{if $middleName} {$middleName|escape}{/if}{if $affiliation}, {$affiliation|escape}{/if}{if $country}, {$country|escape}{/if}</h3>
<ul>
{foreach from=$publishedPapers item=paper}
	{assign var=schedConfId value=$paper->getSchedConfId()}
	{assign var=schedConf value=$schedConfs[$schedConfId]}
	{assign var=schedConfUnavailable value=$schedConfsUnavailable.$schedConfId}
	{assign var=conferenceId value=$schedConf->getConferenceId()}
	{assign var=conference value=$conferences[$conferenceId]}
	{assign var=trackId value=$paper->getTrackId()}
	{assign var=track value=$tracks[$trackId]}
	{if !$schedConfUnavailable}
	<li>

		<em><a href="{url conference=$conference->getPath() schedConf=$schedConf->getPath()}">{$schedConf->getFullTitle()|escape}</a> - {$track->getTrackTitle()|escape}</em><br />
		{$paper->getPaperTitle()|strip_unsafe_html}<br/>
		<a href="{url conference=$conference->getPath() schedConf=$schedConf->getPath() page="paper" op="view" path=$paper->getBestPaperId()}" class="file">{translate key="paper.abstract"}</a>
		{foreach from=$paper->getLocalizedGalleys() item=galley name=galleyList}
			&nbsp;<a href="{url conference=$conference->getPath() schedConf=$schedConf->getPath() page="paper" op="view" path=$paper->getBestPaperId()|to_array:$galley->getGalleyId()}" class="file">{$galley->getGalleyLabel()|escape}</a>
		{/foreach}
	</li>
	{/if}
{/foreach}
</ul>

{include file="common/footer.tpl"}