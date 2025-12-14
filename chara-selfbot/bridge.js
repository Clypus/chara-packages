/**
 * Chara Selfbot Bridge - Node.js Backend
 * Uses discord.js-selfbot-v13
 * 
 * This script is called by Chara's selfbot module
 */

const { Client } = require('discord.js-selfbot-v13');

// Get command line arguments
const args = process.argv.slice(2);
const action = args[0];
const token = args[1];

// Create client
const client = new Client({
    checkUpdate: false,
});

// Action handlers
const actions = {
    // Send message to channel
    send: async () => {
        const channelId = args[2];
        const message = args[3];

        await client.login(token);
        const channel = await client.channels.fetch(channelId);
        await channel.send(message);
        console.log(JSON.stringify({ success: true, action: 'send' }));
        process.exit(0);
    },

    // Get user info
    user: async () => {
        await client.login(token);
        const user = client.user;
        console.log(JSON.stringify({
            id: user.id,
            username: user.username,
            discriminator: user.discriminator,
            tag: user.tag
        }));
        process.exit(0);
    },

    // Get guilds
    guilds: async () => {
        await client.login(token);
        const guilds = client.guilds.cache.map(g => ({
            id: g.id,
            name: g.name,
            memberCount: g.memberCount
        }));
        console.log(JSON.stringify(guilds));
        process.exit(0);
    },

    // Get messages from channel
    messages: async () => {
        const channelId = args[2];
        const limit = parseInt(args[3]) || 10;

        await client.login(token);
        const channel = await client.channels.fetch(channelId);
        const messages = await channel.messages.fetch({ limit });

        const result = messages.map(m => ({
            id: m.id,
            content: m.content,
            author: m.author.tag,
            timestamp: m.createdTimestamp
        }));
        console.log(JSON.stringify(result));
        process.exit(0);
    },

    // Send DM
    dm: async () => {
        const userId = args[2];
        const message = args[3];

        await client.login(token);
        const user = await client.users.fetch(userId);
        await user.send(message);
        console.log(JSON.stringify({ success: true, action: 'dm' }));
        process.exit(0);
    },

    // Add reaction
    react: async () => {
        const channelId = args[2];
        const messageId = args[3];
        const emoji = args[4];

        await client.login(token);
        const channel = await client.channels.fetch(channelId);
        const message = await channel.messages.fetch(messageId);
        await message.react(emoji);
        console.log(JSON.stringify({ success: true, action: 'react' }));
        process.exit(0);
    },

    // Delete message
    delete: async () => {
        const channelId = args[2];
        const messageId = args[3];

        await client.login(token);
        const channel = await client.channels.fetch(channelId);
        const message = await channel.messages.fetch(messageId);
        await message.delete();
        console.log(JSON.stringify({ success: true, action: 'delete' }));
        process.exit(0);
    },

    // Edit message
    edit: async () => {
        const channelId = args[2];
        const messageId = args[3];
        const newContent = args[4];

        await client.login(token);
        const channel = await client.channels.fetch(channelId);
        const message = await channel.messages.fetch(messageId);
        await message.edit(newContent);
        console.log(JSON.stringify({ success: true, action: 'edit' }));
        process.exit(0);
    },

    // Set status
    status: async () => {
        const status = args[2]; // online, idle, dnd, invisible
        const activityType = args[3]; // PLAYING, STREAMING, LISTENING, WATCHING
        const activityName = args[4];

        await client.login(token);
        client.user.setPresence({
            status: status,
            activities: [{
                name: activityName,
                type: activityType
            }]
        });
        console.log(JSON.stringify({ success: true, action: 'status' }));
        setTimeout(() => process.exit(0), 1000);
    },

    // Set nickname
    nickname: async () => {
        const guildId = args[2];
        const nickname = args[3];

        await client.login(token);
        const guild = await client.guilds.fetch(guildId);
        await guild.members.me.setNickname(nickname);
        console.log(JSON.stringify({ success: true, action: 'nickname' }));
        process.exit(0);
    },

    // Run bot (continuous)
    run: async () => {
        client.on('ready', () => {
            console.log(`✅ Logged in as ${client.user.tag}`);
        });

        client.on('messageCreate', (message) => {
            // Output message for Chara to process
            console.log(JSON.stringify({
                event: 'message',
                id: message.id,
                content: message.content,
                author: message.author.tag,
                authorId: message.author.id,
                channelId: message.channel.id,
                guildId: message.guild?.id || null
            }));
        });

        await client.login(token);
    }
};

// Error handler
client.on('error', (error) => {
    console.error(JSON.stringify({ error: error.message }));
});

// Run action
if (actions[action]) {
    actions[action]().catch(err => {
        console.error(JSON.stringify({ error: err.message }));
        process.exit(1);
    });
} else {
    console.log(JSON.stringify({ error: `Unknown action: ${action}` }));
    process.exit(1);
}
