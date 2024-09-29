// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
	integrations: [
		starlight({
			title: 'Figmage',
			social: {
				github: 'https://github.com/whynotmake-it/figmage',
			},
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
