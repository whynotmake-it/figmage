// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import starlightThemeRapidePlugin from 'starlight-theme-rapide';

// https://astro.build/config
export default defineConfig({
	integrations: [
		starlight({
			plugins: [starlightThemeRapidePlugin()],
			title: 'Figmage',
			social: [
				{
					icon: 'github',
					label: 'GitHub',
					href: 'https://github.com/whynotmake-it/figmage',
				}
			],
			sidebar: [
				{
					label: 'Guides',
					autogenerate: { directory: 'guides' },
				},
				{
					label: 'Reference',
					autogenerate: { directory: 'reference' },
				},
			],

		}),
	],
});
