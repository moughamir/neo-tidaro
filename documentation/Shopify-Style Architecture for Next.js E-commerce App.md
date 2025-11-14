# Shopify-Style Architecture for Next.js E-commerce App

Based on the Shopify theme architecture components you've provided, I'll map them to Next.js equivalents and design a file/folder structure that mimics Shopify's organization.

## Mapping Shopify Components to Next.js

| Shopify Component | Next.js Equivalent | Description |
|-------------------|-------------------|-------------|
| 1. Layout File | `app/layout.tsx` | Base structure with repeated elements like header/footer |
| 2. Template | Page templates in `app/(shop)/[template]/page.tsx` | Controls page display based on content type |
| 3. Section Groups | Component collections in `components/section-groups/` | Containers for header/footer customizable sections |
| 4. Sections | Components in `components/sections/` | Reusable, customizable content modules |
| 5. Blocks | Components in `components/blocks/` | Smaller reusable modules that compose sections |
| 6. Snippets | Components in `components/ui/` | Reusable code pieces rendered anywhere |

## Proposed File Structure

```
src/
├── app/
│   ├── layout.tsx                     # [1] Base layout with header/footer
│   ├── page.tsx                       # Home page
│   ├── (shop)/                        # Shop routes group
│   │   ├── products/                  
│   │   │   ├── [handle]/page.tsx      # [2] Product template
│   │   ├── collections/
│   │   │   ├── [handle]/page.tsx      # [2] Collection template
│   │   ├── cart/
│   │   │   ├── page.tsx               # [2] Cart template
│   ├── api/                           # API routes
├── components/
│   ├── section-groups/                # [3] Section groups
│   │   ├── Header.tsx                 # Header section group
│   │   ├── Footer.tsx                 # Footer section group
│   ├── sections/                      # [4] Sections
│   │   ├── hero/
│   │   │   ├── HeroBanner.tsx         # Hero banner section
│   │   │   ├── HeroSlider.tsx         # Hero slider section
│   │   ├── product/
│   │   │   ├── ProductGrid.tsx        # Product grid section
│   │   │   ├── FeaturedProduct.tsx    # Featured product section
│   │   ├── collection/
│   │   │   ├── CollectionList.tsx     # Collection list section
│   │   ├── testimonial/
│   │   │   ├── TestimonialSlider.tsx  # Testimonial slider section
│   ├── blocks/                        # [5] Blocks
│   │   ├── product/
│   │   │   ├── ProductCard.tsx        # Product card block
│   │   │   ├── ProductGallery.tsx     # Product gallery block
│   │   │   ├── ProductVariant.tsx     # Product variant selector block
│   │   ├── content/
│   │   │   ├── RichText.tsx           # Rich text block
│   │   │   ├── ImageWithText.tsx      # Image with text block
│   ├── ui/                            # [6] Snippets/reusable components
│   │   ├── Button.tsx
│   │   ├── Badge.tsx
│   │   ├── Card.tsx
│   │   ├── Price.tsx
│   │   ├── Skeleton.tsx
├── lib/
│   ├── product-utils.ts               # Product utilities
│   ├── product-schema.ts              # Product schema generation
│   ├── theme-config.ts                # Theme configuration (mimics settings_schema.json)
```

## Implementation Details

### 1. Layout (`app/layout.tsx`)
This is the base structure that wraps all pages, containing the header and footer section groups.

```tsx
import { Header } from "@/components/section-groups/Header";
import { Footer } from "@/components/section-groups/Footer";

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>
        <Header />
        <main>{children}</main>
        <Footer />
      </body>
    </html>
  );
}
```

### 2. Templates (`app/(shop)/products/[handle]/page.tsx`)
These are page components for different content types (products, collections, etc.).

```tsx
// Product template
import { ProductDetailSection } from "@/components/sections/product/ProductDetail";
import { RecommendedProducts } from "@/components/sections/product/RecommendedProducts";
import { fetchProduct } from "@/lib/data";

export default async function ProductPage({ params }: { params: { handle: string } }) {
  const product = await fetchProduct(params.handle);
  
  return (
    <div className="container mx-auto">
      <ProductDetailSection product={product} />
      <RecommendedProducts productId={product.id} />
    </div>
  );
}
```

### 3. Section Groups (`components/section-groups/Header.tsx`)
Container components that allow merchants to customize sections in specific layout areas.

```tsx
import { Navigation } from "@/components/sections/header/Navigation";
import { SearchBar } from "@/components/sections/header/SearchBar";
import { Announcement } from "@/components/sections/header/Announcement";

export function Header() {
  return (
    <header>
      <Announcement />
      <div className="container mx-auto flex justify-between items-center py-4">
        <div className="logo">Logo</div>
        <Navigation />
        <div className="flex items-center gap-4">
          <SearchBar />
          <CartIcon />
        </div>
      </div>
    </header>
  );
}
```

### 4. Sections (`components/sections/product/FeaturedProduct.tsx`)
Reusable content modules that can be added to templates.

```tsx
import { ProductGallery } from "@/components/blocks/product/ProductGallery";
import { ProductInfo } from "@/components/blocks/product/ProductInfo";
import { AddToCart } from "@/components/blocks/product/AddToCart";
import type { Product } from "@/lib/types";

interface FeaturedProductProps {
  product: Product;
  layout?: "standard" | "image-first" | "text-first";
}

export function FeaturedProduct({ product, layout = "standard" }: FeaturedProductProps) {
  return (
    <section className="py-12">
      <div className={`grid grid-cols-1 md:grid-cols-2 gap-8 ${layout === "text-first" ? "flex-row-reverse" : ""}`}>
        <ProductGallery images={product.images} />
        <div>
          <ProductInfo product={product} />
          <AddToCart product={product} />
        </div>
      </div>
    </section>
  );
}
```

### 5. Blocks (`components/blocks/product/ProductCard.tsx`)
Smaller components that can be added to sections.

```tsx
import Image from "next/image";
import { Price } from "@/components/ui/Price";
import { useProduct } from "@/hooks/useProduct";
import type { Product } from "@/lib/types";

interface ProductCardProps {
  product: Product;
  showVendor?: boolean;
  showPrice?: boolean;
}

export function ProductCard({ product, showVendor = true, showPrice = true }: ProductCardProps) {
  const { price, comparePrice, image } = useProduct(product);
  
  return (
    <div className="group">
      <div className="aspect-square overflow-hidden rounded-lg">
        <Image 
          src={image.src}
          alt={image.alt}
          width={500}
          height={500}
          className="object-cover group-hover:scale-105 transition-transform duration-300"
        />
      </div>
      <h3 className="mt-4 text-lg font-medium">{product.title}</h3>
      {showVendor && product.vendor && (
        <p className="text-sm text-gray-500">{product.vendor}</p>
      )}
      {showPrice && (
        <Price price={price} comparePrice={comparePrice} />
      )}
    </div>
  );
}
```

### 6. Snippets (`components/ui/Price.tsx`)
Small, reusable components used across the application.

```tsx
import { formatPrice } from "@/lib/product-utils";

interface PriceProps {
  price: number;
  comparePrice?: number | null;
}

export function Price({ price, comparePrice }: PriceProps) {
  const hasDiscount = comparePrice && comparePrice > price;
  
  return (
    <div className="flex items-center gap-2 mt-2">
      <span className="font-medium">{formatPrice(price)}</span>
      {hasDiscount && (
        <span className="text-gray-500 line-through text-sm">
          {formatPrice(comparePrice)}
        </span>
      )}
    </div>
  );
}
```

## Theme Configuration

Create a theme configuration system that mimics Shopify's settings_schema.json:

```tsx
// lib/theme-config.ts
export const themeSettings = {
  colors: {
    primary: {
      label: "Primary Color",
      default: "#000000",
    },
    secondary: {
      label: "Secondary Color",
      default: "#ffffff",
    },
    accent: {
      label: "Accent Color",
      default: "#f3f4f6",
    },
  },
  typography: {
    bodyFont: {
      label: "Body Font",
      default: "Inter",
      options: ["Inter", "Roboto", "Open Sans"],
    },
    headingFont: {
      label: "Heading Font",
      default: "Inter",
      options: ["Inter", "Playfair Display", "Montserrat"],
    },
  },
  layout: {
    containerWidth: {
      label: "Container Width",
      default: "1280px",
      options: ["1024px", "1280px", "1440px"],
    },
  },
};
```



# Implementing Shopify-Style Architecture in Your Next.js App

Based on your current project structure and the Shopify architecture you want to mimic, here are specific recommendations tailored to your Cosmopolitan app:

## Immediate Implementation Plan

1. **Preserve Current Organization While Adding Shopify Structure**
   - Keep your current `components/common`, `components/home`, etc. folders
   - Introduce the new Shopify-style folders alongside them

2. **Map Your Current Components to Shopify Concepts**

Current files like:
```
/app/(shop)/page.tsx                → Template (Home page template)
/components/common/PageScroller.tsx → Snippet (Reusable utility component)
/components/common/Header.tsx       → Section Group (Contains multiple sections)
/components/home/HeroSection.tsx    → Section (Major content module)
/components/home/FeaturedItems.tsx  → Section (Major content module)
```

## Refactored Structure Example

```
src/
├── app/
│   ├── layout.tsx                      # [1] Layout (existing layout)
│   ├── (shop)/
│   │   ├── page.tsx                    # [2] Home template (keep as-is)
│   │   ├── products/
│   │   │   ├── [id]/page.tsx           # [2] Product detail template
├── components/
│   ├── section-groups/                 # [3] Section groups
│   │   ├── Header/
│   │   │   ├── index.tsx               # Main header component
│   │   │   ├── sections.json           # Configuration for included sections
│   │   ├── Footer/
│   │   │   ├── index.tsx               # Main footer component
│   │   │   ├── sections.json           # Configuration for included sections
│   ├── sections/                       # [4] Sections 
│   │   ├── hero/
│   │   │   ├── HeroSection.tsx         # Your existing hero section
│   │   │   ├── schema.json             # Configuration options (like Shopify)
│   │   ├── featured-products/
│   │   │   ├── FeaturedItems.tsx       # Your existing featured items
│   │   │   ├── schema.json             # Configuration options
│   ├── blocks/                         # [5] Blocks
│   │   ├── product/
│   │   │   ├── ProductCard.tsx         # Product card used in multiple sections
│   │   │   ├── schema.json             # Block configuration options
│   ├── ui/                             # [6] Snippets (keep your common/ folder or merge)
│   │   ├── PageScroller.tsx            # Your existing page scroller
├── lib/                                # Utilities (keep existing structure)
│   ├── theme/                          # New theme configuration system
│   │   ├── settings.ts                 # Theme settings (like settings_schema.json)
│   │   ├── config.ts                   # Theme configuration loader
```

## Adapting Your Homepage

Here's how your current homepage could be restructured while keeping its functionality:

```tsx
// app/(shop)/page.tsx
import { HomeHero } from "@/components/sections/hero/HomeHero";
import { FeaturedProducts } from "@/components/sections/featured-products/FeaturedProducts";
import { PageScroller } from "@/components/ui/PageScroller";
import { getBreadcrumbSchema, renderSchema } from "@/lib/schema";

export default function Home() {
  const breadcrumbs = [{ name: "Home", url: "/" }];

  // In Shopify, this would be dynamically configured based on theme settings
  const sections = [
    { 
      type: "hero",
      id: "hero-1",
      settings: { /* Hero section settings */ }
    },
    { 
      type: "featured-products", 
      id: "featured-1",
      settings: { title: "Featured Items", product_count: 8 }
    }
  ];

  return (
    <main
      data-snap-container="true"
      className="min-h-dvh overflow-y-auto overscroll-y-contain antialiased scroll-smooth snap-proximity snap-y"
    >
      {renderSchema(getBreadcrumbSchema(breadcrumbs))}
      <PageScroller />
      
      {/* Render sections based on configuration */}
      {sections.map(section => {
        if (section.type === "hero") {
          return <HomeHero key={section.id} settings={section.settings} />;
        }
        if (section.type === "featured-products") {
          return <FeaturedProducts key={section.id} settings={section.settings} />;
        }
      })}
    </main>
  );
}
```

## Theme Configuration System

Create a theme settings system similar to Shopify's settings_schema.json:

```typescript
// lib/theme/settings.ts
export const themeSettings = {
  // Match your brand colors and styles
  colors: {
    primary: {
      label: "Primary Color",
      default: "#000000",
    },
    accent: {
      label: "Accent Color", 
      default: "#6366f1", // Current purple accent
    }
  },
  // Configurable sections for templates
  homepage: {
    sections: [
      {
        type: "hero",
        label: "Hero Section",
        enabled: true,
        settings: {
          image: "/hero-default.jpg",
          heading: "Welcome to Cosmopolitan",
          subheading: "Discover premium products",
          button_text: "Shop Now",
          button_link: "/products"
        }
      },
      {
        type: "featured_products",
        label: "Featured Products",
        enabled: true,
        settings: {
          title: "Featured Items",
          product_count: 8,
          columns_desktop: 4,
          columns_mobile: 2
        }
      }
    ]
  }
};
```

## Benefits of This Approach

1. **Gradual Migration**: You can incrementally adopt this structure without breaking existing code
2. **Configurable Components**: Section and block settings enable admin customization
3. **Theme System**: Settings allow for theme variants without code changes
4. **Consistent Structure**: Developers familiar with Shopify can easily navigate your codebase
5. **Flexibility**: Components can be freely composed and reordered based on configuration

This approach gives you the best of both worlds: the modern architecture of Next.js with the familiar component organization and configurability of Shopify themes.