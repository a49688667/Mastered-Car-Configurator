#ifndef SPRITES_H_INCLUDED
#define SPRITES_H_INCLUDED

#include <SDL.h>
#include <SDL_image.h>

extern SDL_Renderer* renderer;

class Sprite
{
private:
    SDL_Rect index;
    SDL_Rect loc;

public:
    enum renderTypes
    {
        Backgrounds,
        Objects,
        GUI
    };

public:
    enum buttonTypes
    {
        noneButton,
        buttonPressStart,
        buttonVauxAstra,
        buttonVauxMokka,
        buttonMercC,
        buttonMercA,
        buttonNissan,
        buttonColour1,
        buttonColour2,
        buttonColour3,
        buttonColour4,
        buttonColour5,
        specialButton1,
        specialButton2,
        specialButton3,
        specialButton4,
        specialButton5,
        buttonPrint
    };

    int id;
    int renderType;
    int buttonType;
    const char* spriteName;
    int isButton;

    int buttonFlipFlop;
    int extraCost;

    SDL_Surface* surface;
    SDL_Texture* texture;

    const SDL_Rect* P_INDEX;
    const SDL_Rect* P_LOC;

    int renderActive;
    int suspendObject;

    Sprite()
    {
        id = -1;
        renderType = -1;
        buttonType = 0;
        isButton = 0;

        P_INDEX = &index;
        P_LOC = &loc;

        spriteName = NULL;
        renderActive = 0;
        suspendObject = 1;

        buttonFlipFlop = 0;
        extraCost = 0;
    }

    ~Sprite()
    {
        SDL_DestroyTexture(texture);
    }

    void SetStaticLocation(int x, int y)
    {
        Sprite::loc.x = x;
        Sprite::loc.y = y;
    }

    void RenderObject()
    {
        SDL_RenderCopy(renderer,texture,P_INDEX,P_LOC);
    }

    int GetX(void)
    {
        return Sprite::loc.x;
    }

    int GetY(void)
    {
        return Sprite::loc.y;
    }

    void SetIndex(int x, int y)
    {
        Sprite::index.x = x;
        Sprite::index.y = y;
    }

    int GetIndexX(void)
    {
        return Sprite::index.x;
    }

    int GetIndexY(void)
    {
        return Sprite::index.y;
    }

    void SetIndexDimensions(int h, int w)
    {
        Sprite::index.h = h;
        Sprite::index.w = w;
    }

    int GetIndexHeight(void)
    {
        return Sprite::index.h;
    }

    int GetIndexWidth(void)
    {
        return Sprite::index.w;
    }

    void SetDimensions(int h, int w)
    {
        Sprite::loc.h = h;
        Sprite::loc.w = w;
    }

    int GetHeight(void)
    {
        return Sprite::loc.h;
    }

    int GetWidth(void)
    {
        return Sprite::loc.w;
    }

    void SetSpriteSheet(int sheet)
    {
        char arr_png[][80] =
        {
            {"0.png"},
            {"1.png"},
            {"0.1.png"},
            {"0.2.png"},
            {"0.3.png"},
            {"0.4.png"},
            {"Title.png"},
            {"mokka0.png"},//7..
            {"mokka1.png"},
            {"mokka2.png"},
            {"mokka3.png"},
            {"mokka4.png"},
            {"mercC0.png"},//12..
            {"mercC1.png"},
            {"mercC2.png"},
            {"mercC3.png"},
            {"mercA0.png"},//16..
            {"mercA1.png"},
            {"mercA2.png"},
            {"mercA3.png"},
            {"nissan0.png"},
            {"nissan1.png"},
            {"nissan2.png"}
        };

        SDL_RWops *rwop = SDL_RWFromFile(arr_png[sheet], "rb");

        Sprite::surface = IMG_LoadPNG_RW(rwop);

        SDL_SetColorKey(surface, SDL_TRUE, SDL_MapRGB(surface->format,255,102,255));

        Sprite::texture = SDL_CreateTextureFromSurface(renderer, surface);

        SDL_FreeSurface(surface);
    }

    const SDL_Rect* GetRectLoc()
    {
        return P_LOC;
    }
};
#endif // SPRITES_H_INCLUDED
