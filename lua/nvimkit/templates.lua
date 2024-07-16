return {
    ["ts"] = {
        ["+page.svelte"] = [[
<script lang="ts">
    import type { PageData } from './$types';

    export let data: PageData;
</script>
    ]],
        ["+page.ts"] = [[
import type { PageLoad } from './$types';

export const load: PageLoad = async () => {
    return {};
};
        ]],
        ["+page.server.ts"] = [[
import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async () => {
    return {};
};
        ]],
        ["+server.ts"] = [[
import type { RequestHandler } from './$types';

export const GET: RequestHandler = async () => {
    return new Response();
};
        ]],
        ["+layout.svelte"] = [[
<script lang="ts">
    import type { LayoutData } from './$types';

    export let data: LayoutData;
</script>
        ]],
        ["+layout.server.ts"] = [[
import type { LayoutServerLoad } from './$types';

export const load: LayoutServerLoad = async () => {
    return {};
};
        ]],
        ["layout.ts"] = [[
import type { LayoutLoad } from './$types';

export const load: LayoutLoad = async () => {
    return {};
};
        ]],
        ["+error.svelte"] = [[
<script lang="ts">
    import { page } from '$app/stores';
</script>

<h1>{$page.status}: {$page.error?.message}</h1>
       ]],
    },
    ["js"] = {
        ["+page.svelte"] = [[
<script>
    /** @type {import('./$types').PageData} */
    export let data;
</script>
        ]],
        ["+page.js"] = [[
/** @type {import('./$types').PageLoad} */
export async function load() {
    return {};
};
        ]],
        ["+page.server.js"] = [[
/** @type {import('./$types').PageServerLoad} */
export async function load() {
    return {};
};
        ]],
        ["+server.js"] = [[
/** @type {import('./$types').RequestHandler} */
export async function GET() {
    return new Response();
};
        ]],
        ["+layout.svelte"] = [[
<script>
    /** @type {import('./$types').LayoutData} */
    export let data;
</script>
        ]],
        ["+layout.server.js"] = [[
/** @type {import('./$types').LayoutServerLoad} */
export async function load() {
    return {};
}
        ]],
        ["+laytout.js"] = [[
/** @type {import('./$types').LayoutLoad} */
export async function load() {
    return {};
}
        ]],
        ["+error.svelte"] = [[
<script>
    import { page } from '$app/stores';
</script>

<h1>{$page.status}: {$page.error.message}</h1>
        ]],
    }

}
