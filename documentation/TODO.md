---
created_date: 17/09/2025
updated_date: 20/11/2025
---
- [ ] FrontStore => Next

# Integration Guide: Shopify + Next.js + Vercel

I'm building a headless e-commerce storefront using **Next.js**, **Vercel**, and **Shopify**. I need a comprehensive implementation plan covering:

## Core Requirements

1. **Shopify Setup**: Development store, Headless sales channel, storefront creation
2. **Vercel Deployment**: Using Next.js Commerce template with automatic Shopify integration
3. **Theme Configuration**: Setting up Shopify Headless theme for checkout flow
4. **Local Development**: Cloning repo, environment setup, and customization
5. **Webhook Management**: Real-time data synchronization between Shopify and Next.js

## Technical Stack Details

- **Commerce Framework**: Using `@framework` package with Shopify provider
- **Key Hooks Needed**: `useCart`, `useAddItem`, `useCustomer`, etc.
- **GraphQL Operations**: Product queries, cart mutations via Shopify Storefront API
- **Environment Variables**: `NEXT_PUBLIC_SHOPIFY_STORE_DOMAIN`, `NEXT_PUBLIC_SHOPIFY_STOREFRONT_ACCESS_TOKEN`

## Specific Implementation Questions

1. How to properly configure the `.env.local` file with Shopify credentials?
2. What's the best approach for handling cart state across sessions?
3. How to implement wishlist functionality with Shopify?
4. What webhook events should I subscribe to for optimal performance?
5. How to customize the Shopify Headless theme for my brand?

Provide a step-by-step checklist with code snippets where appropriate, focusing on:

- Environment configuration
- Hook implementations for core e-commerce flows
- Theme customization best practices
- Performance optimization techniques
- Error handling strategies

Include references to relevant documentation sections from the provided materials.
