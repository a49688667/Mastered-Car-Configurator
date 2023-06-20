#include <main.h>


namespace rootNamespace
{
int totalSpriteCount = 23; //..which is the actual total number, minus one.

Sprite  S_choiceBackground,
    S_choiceTemplate,
    S_pressStart,
    S_buttonVauxAstra,
    S_buttonVauxMokka,
    S_buttonMercC,
    S_buttonMercA,
    S_buttonNissan,
    S_colourButton1,
    S_colourButton2,
    S_carSpec,
    S_titleScreen,
    S_colourButton3,
    S_colourButton4,
    S_colourButton5,
    S_specialButton1,
    S_specialButton2,
    S_specialButton3,
    S_specialButton4,
    S_specialButton5,
    S_Price,
    S_carDetailExtras,
    S_carImage,
    S_printButton;

Sprite* pSprites[99] =
{
    &S_choiceBackground,&S_choiceTemplate,&S_pressStart,&S_buttonVauxAstra,&S_buttonVauxMokka,&S_buttonMercC,&S_buttonMercA,
    &S_buttonNissan,&S_carSpec,&S_titleScreen,&S_colourButton1,&S_colourButton2,&S_colourButton3,&S_colourButton4,&S_colourButton5,&S_carImage,&S_carDetailExtras,&S_Price,
    &S_specialButton1,&S_specialButton2,&S_specialButton3,&S_specialButton4,&S_specialButton5,&S_printButton
};

long int priceReel[6];
long int priceAccum = RandomNumber(1,799999);
int lastColourCost = 0;
}

int main( int argc, char* args[] )
{
    using namespace rootNamespace;

    Initialise();

    while(!quit)
    {
        if(SyncClock(globalSyncValue))
            doSync = 1;

        if(doSync)
        {
            SDL_PollEvent(&event);

            InputEvents(P_KEYSTATE);

            ProgramState();

            ProgramEvents();

            RenderScene(renderer);

            CyclicalResets();
        }
    }

    Destruct();

    return 0;
}

void InputEvents(const Uint8* P_KEYSTATE)
{
    using namespace rootNamespace;

    MouseState();

    if(P_KEYSTATE[SDL_SCANCODE_ESCAPE])
        quit = SDL_TRUE;

    if(P_KEYSTATE[SDL_SCANCODE_C])
    {
        system("cls");
    }
}

void MouseState()
{
    SDL_PumpEvents();

    mouseButtonState = SDL_GetMouseState(&mouseX, &mouseY);
}

void ButtonEventChecker(int i)
{
    using namespace rootNamespace;

    SDL_Point mP = {mouseX,mouseY};

    if(pSprites[i]->buttonType == pSprites[i]->buttonPressStart)
    {
        if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
        {
            pSprites[i]->SetIndex(pSprites[i]->GetIndexX(),14);
            if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
            {
                progstate = SCENE_CHOOSE;
                controllerVar_PS = 1; //allow us in..
            }
        } else
            pSprites[i]->SetIndex(pSprites[i]->GetIndexX(),0);
    }

    if(pSprites[i]->buttonType == pSprites[i]->buttonPrint)
    {
        if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
        {
            if(event.button.button == SDL_BUTTON_LMASK)
            {
                if(event.button.type == SDL_MOUSEBUTTONUP)
                {
                    if(!pSprites[i]->buttonFlipFlop)
                    {
                        pSprites[i]->buttonFlipFlop = 1;
                    }
                }
            } else if(!pSprites[i]->buttonFlipFlop)
                pSprites[i]->SetIndex(502,794);
            else
                pSprites[i]->SetIndex(502,753);
        } else if(!pSprites[i]->buttonFlipFlop)
        {
            pSprites[i]->SetIndex(502,835);
        } else
        {
            pSprites[i]->SetIndex(502,753);
        }
    }

    if(pSprites[i]->buttonType == pSprites[i]->buttonVauxAstra)
    {
        if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
        {
            pSprites[i]->SetIndex(pSprites[i]->GetIndexX(),631);
            if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
            {
                progstate = SCENE_ASTRA;
                controllerVar_PS = 1;
            }
        } else
            pSprites[i]->SetIndex(pSprites[i]->GetIndexX(),578);
    }

    if(pSprites[i]->buttonType == pSprites[i]->buttonVauxMokka)
    {
        if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
        {
            pSprites[i]->SetIndex(pSprites[i]->GetIndexX(),631);
            if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
            {
                progstate = SCENE_MOKKA;
                controllerVar_PS = 1;
            }
        } else
            pSprites[i]->SetIndex(pSprites[i]->GetIndexX(),578);
    }

    if(pSprites[i]->buttonType == pSprites[i]->buttonMercC)
    {
        if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
        {
            pSprites[i]->SetIndex(pSprites[i]->GetIndexX(),631);
            if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
            {
                progstate = SCENE_BENZ_C;
                controllerVar_PS = 1;
            }
        } else
            pSprites[i]->SetIndex(pSprites[i]->GetIndexX(),578);
    }

    if(pSprites[i]->buttonType == pSprites[i]->buttonMercA)
    {
        if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
        {
            pSprites[i]->SetIndex(pSprites[i]->GetIndexX(),631);
            if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
            {
                progstate = SCENE_BENZ_A;
                controllerVar_PS = 1;
            }
        } else
            pSprites[i]->SetIndex(pSprites[i]->GetIndexX(),578);
    }

    if(pSprites[i]->buttonType == pSprites[i]->buttonNissan)
    {
        if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
        {
            pSprites[i]->SetIndex(pSprites[i]->GetIndexX(),631);
            if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
            {
                progstate = SCENE_MICRA;
                controllerVar_PS = 1;
            }
        } else
            pSprites[i]->SetIndex(pSprites[i]->GetIndexX(),578);
    }

    if(pSprites[i]->buttonType == pSprites[i]->buttonColour1)
    {
        switch(progstate)
        {
            case SCENE_ASTRA:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex(960+23,579);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(2);
                        priceAccum = priceAccum - lastColourCost + 0;
                        lastColourCost = 0;
                    }
                } else
                    pSprites[i]->SetIndex(960,579);
                break;

            case SCENE_MOKKA:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex((960+47)+23,579);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(7);
                        priceAccum = priceAccum - lastColourCost + 0;
                        lastColourCost = 0;
                    }
                } else
                    pSprites[i]->SetIndex((960+47),579);
                break;

            case SCENE_BENZ_C:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex((960+47*2)+23,579);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(12);
                        priceAccum = priceAccum - lastColourCost + 0;
                        lastColourCost = 0;
                    }
                } else
                    pSprites[i]->SetIndex((960+47*2),579);
                break;

            case SCENE_BENZ_A:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex((960+47*3)+23,579);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(16);
                        priceAccum = priceAccum - lastColourCost + 0;
                        lastColourCost = 0;
                    }
                } else
                    pSprites[i]->SetIndex((960+47*3),579);
                break;

            case SCENE_MICRA:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex((960+47*4)+23,579);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(20);
                        priceAccum = priceAccum - lastColourCost + 0;
                        lastColourCost = 0;
                    }
                } else
                    pSprites[i]->SetIndex((960+47*4),579);
                break;

        }

    }

    if(pSprites[i]->buttonType == pSprites[i]->buttonColour2)
    {
        switch(progstate)
        {
            case SCENE_ASTRA:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex(960+23,579+29);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(3);
                        priceAccum = priceAccum - lastColourCost + 1250;
                        lastColourCost = 1250;
                    }
                } else
                    pSprites[i]->SetIndex(960,579+29);
                break;

            case SCENE_MOKKA:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex((960+47)+23,579+29);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(8);
                        priceAccum = priceAccum - lastColourCost + 580;
                        lastColourCost = 580;
                    }
                } else
                    pSprites[i]->SetIndex((960+47),579+29);
                break;

            case SCENE_BENZ_C:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex((960+47*2)+23,579+29);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(13);
                        priceAccum = priceAccum - lastColourCost + 6000;
                        lastColourCost = 6000;
                    }
                } else
                    pSprites[i]->SetIndex((960+47*2),579+29);
                break;

            case SCENE_BENZ_A:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex((960+47*3)+23,579+29);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(17);
                        priceAccum = priceAccum - lastColourCost + 8210;
                        lastColourCost = 8210;
                    }
                } else
                    pSprites[i]->SetIndex((960+47*3),579+29);
                break;

            case SCENE_MICRA:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex((960+47*4)+23,579+29);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(21);
                        priceAccum = priceAccum - lastColourCost + 996;
                        lastColourCost = 996;
                    }
                } else
                    pSprites[i]->SetIndex((960+47*4),579+29);
                break;

        }
    }

    if(pSprites[i]->buttonType == pSprites[i]->buttonColour3)
    {
        switch(progstate)
        {
            case SCENE_ASTRA:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex(960+23,579+29*2);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(4);
                        priceAccum = priceAccum - lastColourCost + 4407;
                        lastColourCost = 4407;
                    }
                } else
                    pSprites[i]->SetIndex(960,579+29*2);
                break;

            case SCENE_MOKKA:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex((960+47)+23,579+29*2);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(9);
                        priceAccum = priceAccum - lastColourCost + 7083;
                        lastColourCost = 7083;
                    }
                } else
                    pSprites[i]->SetIndex((960+47),579+29*2);
                break;

            case SCENE_BENZ_C:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex((960+47*2)+23,579+29*2);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(14);
                        priceAccum = priceAccum - lastColourCost + 4180;
                        lastColourCost = 4180;
                    }
                } else
                    pSprites[i]->SetIndex((960+47*2),579+29*2);
                break;

            case SCENE_BENZ_A:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex((960+47*3)+23,579+29*2);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(18);
                        priceAccum = priceAccum - lastColourCost + 9840;
                        lastColourCost = 9840;
                    }
                } else
                    pSprites[i]->SetIndex((960+47*3),579+29*2);
                break;

            case SCENE_MICRA:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex((960+47*4)+23,579+29*2);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(22);
                        priceAccum = priceAccum - lastColourCost + 346;
                        lastColourCost = 346;
                    }
                } else
                    pSprites[i]->SetIndex((960+47*4),579+29*2);
                break;

        }
    }

    if(pSprites[i]->buttonType == pSprites[i]->buttonColour4)
    {
        switch(progstate)
        {
            case SCENE_ASTRA:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex(960+23,579+29*3);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(5);
                        priceAccum = priceAccum - lastColourCost + 6093;
                        lastColourCost = 6093;
                    }
                } else
                    pSprites[i]->SetIndex(960,579+29*3);
                break;

            case SCENE_MOKKA:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex((960+47)+23,579+29*3);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(10);
                        priceAccum = priceAccum - lastColourCost + 2457;
                        lastColourCost = 2457;
                    }
                } else
                    pSprites[i]->SetIndex((960+47),579+29*3);
                break;

            case SCENE_BENZ_C:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex((960+47*2)+23,579+29*3);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(15);
                        priceAccum = priceAccum - lastColourCost + 2457;
                        lastColourCost = 2457;
                    }
                } else
                    pSprites[i]->SetIndex((960+47*2),579+29*3);
                break;

            case SCENE_BENZ_A:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex((960+47*3)+23,579+29*3);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(19);
                        priceAccum = priceAccum - lastColourCost + 4901;
                        lastColourCost = 4901;
                    }
                } else
                    pSprites[i]->SetIndex((960+47*3),579+29*3);
                break;

        }
    }

    if(pSprites[i]->buttonType == pSprites[i]->buttonColour5)
    {
        switch(progstate)
        {
            case SCENE_ASTRA:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex(960+23,579+29*4);
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        //
                    }
                } else
                    pSprites[i]->SetIndex(960,579+29*4);
                break;

            case SCENE_MOKKA:
                if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
                {
                    pSprites[i]->SetIndex((960+47)+23,579+(29*4));
                    if((mouseButtonState & SDL_BUTTON_LMASK) != 0)
                    {
                        S_carImage.SetSpriteSheet(11);
                        priceAccum = priceAccum - lastColourCost + 9830;
                        lastColourCost = 9830;
                    }
                } else
                    pSprites[i]->SetIndex((960+47),579+(29*4));
                break;

        }
    }

    if(pSprites[i]->buttonType == pSprites[i]->specialButton1)
    {
        if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
        {
            if(event.button.button == SDL_BUTTON_LMASK)
            {
                if(event.button.type == SDL_MOUSEBUTTONUP)
                {
                    if(!pSprites[i]->buttonFlipFlop)
                    {
                        pSprites[i]->buttonFlipFlop = 1;
                        priceAccum = priceAccum + pSprites[i]->extraCost;
                    }
                    else
                    {
                        pSprites[i]->buttonFlipFlop = 0;
                        priceAccum = priceAccum - pSprites[i]->extraCost;
                    }
                }
            } else if(!pSprites[i]->buttonFlipFlop)
                pSprites[i]->SetIndex(0,794);
            else
                pSprites[i]->SetIndex(0,794);
        } else if(!pSprites[i]->buttonFlipFlop)
        {
            pSprites[i]->SetIndex(0,835);//not to buy..
        } else
        {
            pSprites[i]->SetIndex(0,753);//to buy..
        }
    }

    if(pSprites[i]->buttonType == pSprites[i]->specialButton2)
    {
        if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
        {
            if(event.button.button == SDL_BUTTON_LMASK)
            {
                if(event.button.type == SDL_MOUSEBUTTONUP)
                {
                    if(!pSprites[i]->buttonFlipFlop)
                    {
                        pSprites[i]->buttonFlipFlop = 1;
                        priceAccum = priceAccum + pSprites[i]->extraCost;
                    }
                    else
                    {
                        pSprites[i]->buttonFlipFlop = 0;
                        priceAccum = priceAccum - pSprites[i]->extraCost;
                    }
                }
            } else if(!pSprites[i]->buttonFlipFlop)
                pSprites[i]->SetIndex(90,794);
            else
                pSprites[i]->SetIndex(90,794);
        } else if(!pSprites[i]->buttonFlipFlop)
        {
            pSprites[i]->SetIndex(90,835);//not to buy..
        } else
        {
            pSprites[i]->SetIndex(90,753);//to buy..
        }
    }

    if(pSprites[i]->buttonType == pSprites[i]->specialButton3)
    {
        if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
        {
            if(event.button.button == SDL_BUTTON_LMASK)
            {
                if(event.button.type == SDL_MOUSEBUTTONUP)
                {
                    if(!pSprites[i]->buttonFlipFlop)
                    {
                        pSprites[i]->buttonFlipFlop = 1;
                        priceAccum = priceAccum + pSprites[i]->extraCost;
                    }
                    else
                    {
                        pSprites[i]->buttonFlipFlop = 0;
                        priceAccum = priceAccum - pSprites[i]->extraCost;
                    }
                }
            } else if(!pSprites[i]->buttonFlipFlop)
                pSprites[i]->SetIndex(189,794);
            else
                pSprites[i]->SetIndex(189,794);
        } else if(!pSprites[i]->buttonFlipFlop)
        {
            pSprites[i]->SetIndex(189,835);//not to buy..
        } else
        {
            pSprites[i]->SetIndex(189,753);//to buy..
        }
    }

    if(pSprites[i]->buttonType == pSprites[i]->specialButton4)
    {
        if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
        {
            if(event.button.button == SDL_BUTTON_LMASK)
            {
                if(event.button.type == SDL_MOUSEBUTTONUP)
                {
                    if(!pSprites[i]->buttonFlipFlop)
                    {
                        pSprites[i]->buttonFlipFlop = 1;
                        priceAccum = priceAccum + pSprites[i]->extraCost;
                    }
                    else
                    {
                        pSprites[i]->buttonFlipFlop = 0;
                        priceAccum = priceAccum - pSprites[i]->extraCost;
                    }
                }
            } else if(!pSprites[i]->buttonFlipFlop)
                pSprites[i]->SetIndex(242,794);
            else
                pSprites[i]->SetIndex(242,794);
        } else if(!pSprites[i]->buttonFlipFlop)
        {
            pSprites[i]->SetIndex(242,835);//not to buy..
        } else
        {
            pSprites[i]->SetIndex(242,753);//to buy..
        }
    }

    if(pSprites[i]->buttonType == pSprites[i]->specialButton5)
    {
        if(SDL_PointInRect(&mP,pSprites[i]->GetRectLoc()))
        {
            if(event.button.button == SDL_BUTTON_LMASK)
            {
                if(event.button.type == SDL_MOUSEBUTTONUP)
                {
                    if(!pSprites[i]->buttonFlipFlop)
                    {
                        pSprites[i]->buttonFlipFlop = 1;
                        priceAccum = priceAccum + pSprites[i]->extraCost;
                    }
                    else
                    {
                        pSprites[i]->buttonFlipFlop = 0;
                        priceAccum = priceAccum - pSprites[i]->extraCost;
                    }
                }
            } else if(!pSprites[i]->buttonFlipFlop)
                pSprites[i]->SetIndex(382,794);
            else
                pSprites[i]->SetIndex(382,794);
        } else if(!pSprites[i]->buttonFlipFlop)
        {
            pSprites[i]->SetIndex(382,835);//not to buy..
        } else
        {
            pSprites[i]->SetIndex(382,753);//to buy..
        }
    }
}

void Initialise(void)
{
    SCREEN_HEIGHT = 540;
    SCREEN_WIDTH = 960;

    window = SDL_CreateWindow( "Mastered Car Configurator", SCREEN_WIDTH/2, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_ALWAYS_ON_TOP | SDL_WINDOW_BORDERLESS);
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    SDL_RenderSetLogicalSize(renderer,SCREEN_WIDTH,SCREEN_HEIGHT);

    quit = SDL_FALSE;

    InitialiseSprites();

    progstate = TITLESCREEN;
    controllerVar_PS = 1;
}

void Destruct(void)
{
    using namespace rootNamespace;

    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
}

void RenderScene(SDL_Renderer *renderer)
{
    using namespace rootNamespace;

    for(int i=0; i<=totalSpriteCount; i++)
    {
        if(!pSprites[i]->suspendObject)
        {
            if(pSprites[i]->renderActive)
            {
                switch(pSprites[i]->renderType)
                {
                case pSprites[i]->Backgrounds:
                    pSprites[i]->RenderObject();
                }
            }
        }
    }

    for(int i=0; i<=totalSpriteCount; i++)
    {
        if(!pSprites[i]->suspendObject)
        {
            if(pSprites[i]->renderActive)
            {
                if(pSprites[i]->renderType != pSprites[i]->Backgrounds &&
                   pSprites[i]->renderType != pSprites[i]->GUI)
                {
                    pSprites[i]->RenderObject();
                }
            }
        }
    }

    for(int i=0; i<=totalSpriteCount; i++)
    {
    if(!pSprites[i]->suspendObject)
        {
            if(pSprites[i]->renderActive && pSprites[i]->renderType == pSprites[i]->GUI)
            {
                pSprites[i]->RenderObject();
            }
        }
    }

    if(!S_Price.suspendObject)
        PriceGraphicParser();

    SDL_RenderPresent(renderer);
    SDL_RenderClear(renderer);
}

void PriceGraphicParser()
{
    using namespace rootNamespace;

    long int tempPriceAccum = priceAccum;

    for(int i=5;i>0;i--)
    {
        if(i==1)
        {
            priceReel[i] = tempPriceAccum%10;
            priceReel[i-1] = tempPriceAccum/10;

            break;
        }

        priceReel[i] = tempPriceAccum%10;
        tempPriceAccum = tempPriceAccum/10;
    }

    int renderRight = 0;

    for(int i=0;i<6;i++)
    {
        switch(priceReel[i])
        {
        case 0:
            S_Price.SetIndex(227,0);
            break;
        case 1:
            S_Price.SetIndex(227+13,0);
            break;
        case 2:
            S_Price.SetIndex(227+(13*2),0);
            break;
        case 3:
            S_Price.SetIndex(227+(13*3),0);
            break;
        case 4:
            S_Price.SetIndex(227+(13*4),0);
            break;
        case 5:
            S_Price.SetIndex(227+(13*5),0);
            break;
        case 6:
            S_Price.SetIndex(227+(13*6),0);
            break;
        case 7:
            S_Price.SetIndex(227+(13*7),0);
            break;
        case 8:
            S_Price.SetIndex(227+(13*8),0);
            break;
        case 9:
            S_Price.SetIndex(227+(13*9),0);
            break;
        }

        S_Price.SetStaticLocation(448+renderRight,407);

        S_Price.RenderObject();

        if(priceReel[i] == 1)
            renderRight += 11;
        else
            renderRight += 17;
    }
}

int SyncClock(Uint64 syncValue)
{
    using namespace rootNamespace;

    if(timeInitAccess)
    {
        timeStartStamp = SDL_GetTicks64();
        timeInitAccess = 0;
    }

    if(SDL_GetTicks64() >= (timeStartStamp + syncValue))
    {
        timeInitAccess = 1;
        timeStartStamp = 0;
        return 1;
    }

    return 0;
}

int RandomNumber(int lowest, int highest)
{
    std::random_device rd;
    std::mt19937 generator(rd());
    std::uniform_int_distribution<> range(lowest, highest);

    return range(generator);
}

void ProgramState()
{
    using namespace rootNamespace;

    if(controllerVar_PS)
    {
        switch(progstate)
        {
        case TITLESCREEN:
            S_Price.SetStaticLocation(0,-25);//hack to stop initial graphic issue..
            break;

        case SCENE_CHOOSE:
            S_choiceBackground.suspendObject = 0;
            S_buttonVauxAstra.suspendObject = 0;
            S_buttonVauxAstra.SetStaticLocation(14,14);
            S_buttonVauxMokka.suspendObject = 0;
            S_buttonVauxMokka.SetStaticLocation(203,14);
            S_buttonMercC.suspendObject = 0;
            S_buttonMercC.SetStaticLocation(392,14);
            S_buttonMercA.suspendObject = 0;
            S_buttonMercA.SetStaticLocation(581,14);
            S_buttonNissan.suspendObject = 0;
            S_buttonNissan.SetStaticLocation(770,14);
            S_printButton.suspendObject = 0;

            S_pressStart.suspendObject = 1;
            S_titleScreen.suspendObject = 1;
            break;

        case SCENE_ASTRA:
            SceneAstra();
            break;

        case SCENE_MOKKA:
            SceneMokka();
            break;

        case SCENE_BENZ_C:
            SceneBenzC();
            break;

        case SCENE_BENZ_A:
            SceneBenzA();
            break;

        case SCENE_MICRA:
            SceneNissan();
            break;
        }
    }

    controllerVar_PS = 0;
}

void SceneAstra()
{
    using namespace rootNamespace;

    S_printButton.suspendObject = 1;
    S_buttonVauxAstra.isButton = 0;
    S_buttonVauxMokka.isButton = 1;
    S_buttonMercC.isButton = 1;
    S_buttonMercA.isButton = 1;
    S_buttonNissan.isButton = 1;

    S_choiceTemplate.suspendObject = 0;
    S_buttonVauxAstra.SetIndex(S_buttonVauxAstra.GetIndexX(),684);
    S_buttonVauxAstra.SetIndexDimensions(69,176);
    S_buttonVauxAstra.SetDimensions(69,176);
    S_carImage.suspendObject = 0;
    S_carSpec.SetIndex(1375,564);
    S_carSpec.suspendObject = 0;
    S_carImage.SetSpriteSheet(2);
    S_colourButton1.suspendObject = 0;
    S_colourButton2.suspendObject = 0;
    S_colourButton3.suspendObject = 0;
    S_colourButton4.suspendObject = 0;
    S_colourButton5.suspendObject = 1;
    S_Price.suspendObject = 0;
    priceAccum = 55670;
    lastColourCost = 0;
    S_carDetailExtras.SetIndex(357,0);
    S_carDetailExtras.suspendObject = 0;
        SetExtrasButtons(SCENE_ASTRA);

    S_buttonVauxMokka.SetIndex(S_buttonVauxMokka.GetIndexX(),578);
    S_buttonVauxMokka.SetIndexDimensions(53,176);
    S_buttonVauxMokka.SetDimensions(53,176);
    S_buttonMercC.SetIndex(S_buttonMercC.GetIndexX(),578);
    S_buttonMercC.SetIndexDimensions(53,176);
    S_buttonMercC.SetDimensions(53,176);
    S_buttonMercA.SetIndex(S_buttonMercA.GetIndexX(),578);
    S_buttonMercA.SetIndexDimensions(53,176);
    S_buttonMercA.SetDimensions(53,176);
    S_buttonNissan.SetIndex(S_buttonNissan.GetIndexX(),578);
    S_buttonNissan.SetIndexDimensions(53,176);
    S_buttonNissan.SetDimensions(53,176);
}

void SceneMokka()
{
    using namespace rootNamespace;

    S_printButton.suspendObject = 1;
    S_buttonVauxAstra.isButton = 1;
    S_buttonVauxMokka.isButton = 0;
    S_buttonMercC.isButton = 1;
    S_buttonMercA.isButton = 1;
    S_buttonNissan.isButton = 1;
    S_choiceTemplate.suspendObject = 0;
    S_buttonVauxMokka.SetIndex(S_buttonVauxMokka.GetIndexX(),684);
    S_buttonVauxMokka.SetIndexDimensions(69,176);
    S_buttonVauxMokka.SetDimensions(69,176);
    S_carImage.suspendObject = 0;
    S_carSpec.SetIndex(1375,825);
    S_carSpec.suspendObject = 0;
    S_carImage.SetSpriteSheet(7);
    S_colourButton1.suspendObject = 0;
    S_colourButton2.suspendObject = 0;
    S_colourButton3.suspendObject = 0;
    S_colourButton4.suspendObject = 0;
    S_colourButton5.suspendObject = 0;
    S_Price.suspendObject = 0;
    priceAccum = 135599;
    lastColourCost = 0;
    S_carDetailExtras.SetIndex(465,0);
    S_carDetailExtras.suspendObject = 0;
        SetExtrasButtons(SCENE_MOKKA);

    S_buttonVauxAstra.SetIndex(S_buttonVauxAstra.GetIndexX(),578);
    S_buttonVauxAstra.SetIndexDimensions(53,176);
    S_buttonVauxAstra.SetDimensions(53,176);
    S_buttonMercC.SetIndex(S_buttonMercC.GetIndexX(),578);
    S_buttonMercC.SetIndexDimensions(53,176);
    S_buttonMercC.SetDimensions(53,176);
    S_buttonMercA.SetIndex(S_buttonMercA.GetIndexX(),578);
    S_buttonMercA.SetIndexDimensions(53,176);
    S_buttonMercA.SetDimensions(53,176);
    S_buttonNissan.SetIndex(S_buttonNissan.GetIndexX(),578);
    S_buttonNissan.SetIndexDimensions(53,176);
    S_buttonNissan.SetDimensions(53,176);
}

void SceneBenzC()
{
    using namespace rootNamespace;

    S_printButton.suspendObject = 1;
    S_buttonVauxAstra.isButton = 1;
    S_buttonVauxMokka.isButton = 1;
    S_buttonMercC.isButton = 0;
    S_buttonMercA.isButton = 1;
    S_buttonNissan.isButton = 1;
    S_choiceTemplate.suspendObject = 0;
    S_buttonMercC.SetIndex(S_buttonMercC.GetIndexX(),684);
    S_buttonMercC.SetIndexDimensions(69,176);
    S_buttonMercC.SetDimensions(69,176);
    S_carImage.suspendObject = 0;
    S_carSpec.SetIndex(1375,1086);
    S_carSpec.suspendObject = 0;
    S_carImage.SetSpriteSheet(12);
    S_colourButton1.suspendObject = 0;
    S_colourButton2.suspendObject = 0;
    S_colourButton3.suspendObject = 0;
    S_colourButton4.suspendObject = 0;
    S_colourButton5.suspendObject = 1;
    S_Price.suspendObject = 0;
    priceAccum = 276999;
    lastColourCost = 0;
    S_carDetailExtras.SetIndex(567,0);
    S_carDetailExtras.suspendObject = 0;
        SetExtrasButtons(SCENE_BENZ_C);

    S_buttonVauxAstra.SetIndex(S_buttonVauxAstra.GetIndexX(),578);
    S_buttonVauxAstra.SetIndexDimensions(53,176);
    S_buttonVauxAstra.SetDimensions(53,176);
    S_buttonVauxMokka.SetIndex(S_buttonVauxMokka.GetIndexX(),578);
    S_buttonVauxMokka.SetIndexDimensions(53,176);
    S_buttonVauxMokka.SetDimensions(53,176);
    S_buttonMercA.SetIndex(S_buttonMercA.GetIndexX(),578);
    S_buttonMercA.SetIndexDimensions(53,176);
    S_buttonMercA.SetDimensions(53,176);
    S_buttonNissan.SetIndex(S_buttonNissan.GetIndexX(),578);
    S_buttonNissan.SetIndexDimensions(53,176);
    S_buttonNissan.SetDimensions(53,176);
}

void SceneBenzA()
{
    using namespace rootNamespace;

    S_printButton.suspendObject = 1;
    S_buttonVauxAstra.isButton = 1;
    S_buttonVauxMokka.isButton = 1;
    S_buttonMercA.isButton = 0;
    S_buttonMercC.isButton = 1;
    S_buttonNissan.isButton = 1;
    S_choiceTemplate.suspendObject = 0;
    S_buttonMercA.SetIndex(S_buttonMercA.GetIndexX(),684);
    S_buttonMercA.SetIndexDimensions(69,176);
    S_buttonMercA.SetDimensions(69,176);
    S_carImage.suspendObject = 0;
    S_carSpec.SetIndex(1375,1347);
    S_carSpec.suspendObject = 0;
    S_carImage.SetSpriteSheet(16);
    S_colourButton1.suspendObject = 0;
    S_colourButton2.suspendObject = 0;
    S_colourButton3.suspendObject = 0;
    S_colourButton4.suspendObject = 0;
    S_colourButton5.suspendObject = 1;
    S_Price.suspendObject = 0;
    priceAccum = 407995;
    lastColourCost = 0;
    S_carDetailExtras.SetIndex(675,0);
    S_carDetailExtras.suspendObject = 0;
        SetExtrasButtons(SCENE_BENZ_A);

    S_buttonVauxAstra.SetIndex(S_buttonVauxAstra.GetIndexX(),578);
    S_buttonVauxAstra.SetIndexDimensions(53,176);
    S_buttonVauxAstra.SetDimensions(53,176);
    S_buttonVauxMokka.SetIndex(S_buttonVauxMokka.GetIndexX(),578);
    S_buttonVauxMokka.SetIndexDimensions(53,176);
    S_buttonVauxMokka.SetDimensions(53,176);
    S_buttonMercC.SetIndex(S_buttonMercC.GetIndexX(),578);
    S_buttonMercC.SetIndexDimensions(53,176);
    S_buttonMercC.SetDimensions(53,176);
    S_buttonNissan.SetIndex(S_buttonNissan.GetIndexX(),578);
    S_buttonNissan.SetIndexDimensions(53,176);
    S_buttonNissan.SetDimensions(53,176);
}

void SceneNissan()
{
    using namespace rootNamespace;

    S_printButton.suspendObject = 1;
    S_buttonVauxAstra.isButton = 1;
    S_buttonVauxMokka.isButton = 1;
    S_buttonMercA.isButton = 1;
    S_buttonMercC.isButton = 1;
    S_buttonNissan.isButton = 0;
    S_choiceTemplate.suspendObject = 0;
    S_buttonNissan.SetIndex(S_buttonNissan.GetIndexX(),684);
    S_buttonNissan.SetIndexDimensions(69,176);
    S_buttonNissan.SetDimensions(69,176);
    S_carImage.suspendObject = 0;
    S_carSpec.SetIndex(1375,1608);
    S_carSpec.suspendObject = 0;
    S_carImage.SetSpriteSheet(20);
    S_colourButton1.suspendObject = 0;
    S_colourButton2.suspendObject = 0;
    S_colourButton3.suspendObject = 0;
    S_colourButton4.suspendObject = 1;
    S_colourButton5.suspendObject = 1;
    S_Price.suspendObject = 0;
    priceAccum = 9950;
    lastColourCost = 0;
    S_carDetailExtras.SetIndex(783,0);
    S_carDetailExtras.suspendObject = 0;
        SetExtrasButtons(SCENE_MICRA);

    S_buttonVauxAstra.SetIndex(S_buttonVauxAstra.GetIndexX(),578);
    S_buttonVauxAstra.SetIndexDimensions(53,176);
    S_buttonVauxAstra.SetDimensions(53,176);
    S_buttonVauxMokka.SetIndex(S_buttonVauxMokka.GetIndexX(),578);
    S_buttonVauxMokka.SetIndexDimensions(53,176);
    S_buttonVauxMokka.SetDimensions(53,176);
    S_buttonMercC.SetIndex(S_buttonMercC.GetIndexX(),578);
    S_buttonMercC.SetIndexDimensions(53,176);
    S_buttonMercC.SetDimensions(53,176);
    S_buttonMercA.SetIndex(S_buttonMercA.GetIndexX(),578);
    S_buttonMercA.SetIndexDimensions(53,176);
    S_buttonMercA.SetDimensions(53,176);
}

void ProgramEvents()
{
    using namespace rootNamespace;

    for(int i=0; i<=totalSpriteCount; i++)
    {
        if(!pSprites[i]->suspendObject && pSprites[i]->isButton)
        {
            ButtonEventChecker(i);
        }
    }
}

void InitialiseSprites(void)
{
    using namespace rootNamespace;

    for(int i=0; i<=totalSpriteCount; i++)
    {
        pSprites[i]->id = i+1;
    }

    S_titleScreen.renderType = S_titleScreen.renderTypes::Backgrounds;
    S_titleScreen.spriteName = "S_titleScreen";
    S_titleScreen.SetSpriteSheet(6);
    S_titleScreen.SetIndex(0,0);
    S_titleScreen.SetIndexDimensions(540,960);
    S_titleScreen.SetStaticLocation(0,0);
    S_titleScreen.SetDimensions(540,960);
    S_titleScreen.renderActive = 1;
    S_titleScreen.suspendObject = 0;

    S_choiceBackground.renderType = S_choiceBackground.renderTypes::Backgrounds;
    S_choiceBackground.spriteName = "S_choiceBackground";
    S_choiceBackground.SetSpriteSheet(0);
    S_choiceBackground.SetIndex(0,0);
    S_choiceBackground.SetIndexDimensions(1080,1920);
    S_choiceBackground.SetStaticLocation(0,-38);
    S_choiceBackground.SetDimensions(1080,1920);
    S_choiceBackground.renderActive = 1;

    S_pressStart.renderType = S_pressStart.renderTypes::GUI;
    S_pressStart.buttonType = S_pressStart.buttonTypes::buttonPressStart;
    S_pressStart.spriteName = "S_pressStart";
    S_pressStart.SetSpriteSheet(0);
    S_pressStart.SetIndex(0,0);
    S_pressStart.SetIndexDimensions(14,227);
    S_pressStart.SetStaticLocation(368,375);
    S_pressStart.SetDimensions(14,227);
    S_pressStart.renderActive = 1;
    S_pressStart.isButton = 1;
    S_pressStart.suspendObject = 0;

    S_Price.renderType = S_Price.renderTypes::Objects;
    S_Price.spriteName = "S_Price";
    S_Price.SetSpriteSheet(0);
    S_Price.SetIndexDimensions(18,13);
    S_Price.SetDimensions(18,13);
    S_Price.renderActive = 1;

    S_choiceTemplate.renderType = S_choiceTemplate.renderTypes::Objects;
    S_choiceTemplate.spriteName = "S_choiceTemplate";
    S_choiceTemplate.SetSpriteSheet(0);
    S_choiceTemplate.SetIndex(960,120);
    S_choiceTemplate.SetIndexDimensions(444,932);
    S_choiceTemplate.SetDimensions(444,932);
    S_choiceTemplate.SetStaticLocation(14,82);
    S_choiceTemplate.renderActive = 1;

    S_carImage.renderType = S_carImage.renderTypes::Objects;
    S_carImage.spriteName = "S_carImage";
    S_carImage.SetSpriteSheet(2);
    S_carImage.SetIndex(0,0);
    S_carImage.SetIndexDimensions(250,375);
    S_carImage.SetDimensions(250,375);
    S_carImage.SetStaticLocation(28,96);
    S_carImage.renderActive = 1;

    S_carSpec.renderType = S_carSpec.renderTypes::Objects;
    S_carSpec.spriteName = "S_carSpec";
    S_carSpec.SetSpriteSheet(0);
    S_carSpec.SetIndex(1375,564);
    S_carSpec.SetIndexDimensions(260,489);
    S_carSpec.SetDimensions(260,489);
    S_carSpec.SetStaticLocation(429,137);
    S_carSpec.renderActive = 1;

    S_carDetailExtras.renderType = S_carDetailExtras.renderTypes::Objects;
    S_carDetailExtras.spriteName = "S_carDetailExtras";
    S_carDetailExtras.SetSpriteSheet(0);
    S_carDetailExtras.SetIndex(357,0);
    S_carDetailExtras.SetIndexDimensions(18,98);
    S_carDetailExtras.SetDimensions(18,98);
    S_carDetailExtras.SetStaticLocation(448,477);
    S_carDetailExtras.renderActive = 1;

    MiscButtonSprites();

    CarButtonSprites();
}

void CarButtonSprites()
{
    using namespace rootNamespace;

    S_buttonVauxAstra.renderType = S_buttonVauxAstra.renderTypes::Objects;
    S_buttonVauxAstra.buttonType = S_buttonVauxAstra.buttonTypes::buttonVauxAstra;
    S_buttonVauxAstra.spriteName = "S_buttonVauxAstra";
    S_buttonVauxAstra.SetSpriteSheet(0);
    S_buttonVauxAstra.SetIndex(14,578);
    S_buttonVauxAstra.SetIndexDimensions(53,176);
    S_buttonVauxAstra.SetDimensions(53,176);
    S_buttonVauxAstra.renderActive = 1;
    S_buttonVauxAstra.isButton = 1;

    S_buttonVauxMokka.renderType = S_buttonVauxMokka.renderTypes::Objects;
    S_buttonVauxMokka.buttonType = S_buttonVauxMokka.buttonTypes::buttonVauxMokka;
    S_buttonVauxMokka.spriteName = "S_buttonVauxMokka";
    S_buttonVauxMokka.SetSpriteSheet(0);
    S_buttonVauxMokka.SetIndex(203,578);
    S_buttonVauxMokka.SetIndexDimensions(53,176);
    S_buttonVauxMokka.SetDimensions(53,176);
    S_buttonVauxMokka.renderActive = 1;
    S_buttonVauxMokka.isButton = 1;

    S_buttonMercC.renderType = S_buttonMercC.renderTypes::Objects;
    S_buttonMercC.buttonType = S_buttonMercC.buttonTypes::buttonMercC;
    S_buttonMercC.spriteName = "S_buttonMercC";
    S_buttonMercC.SetSpriteSheet(0);
    S_buttonMercC.SetIndex(392,578);
    S_buttonMercC.SetIndexDimensions(53,176);
    S_buttonMercC.SetDimensions(53,176);
    S_buttonMercC.renderActive = 1;
    S_buttonMercC.isButton = 1;

    S_buttonMercA.renderType = S_buttonMercA.renderTypes::Objects;
    S_buttonMercA.buttonType = S_buttonMercA.buttonTypes::buttonMercA;
    S_buttonMercA.spriteName = "S_buttonMercA";
    S_buttonMercA.SetSpriteSheet(0);
    S_buttonMercA.SetIndex(581,578);
    S_buttonMercA.SetIndexDimensions(53,176);
    S_buttonMercA.SetDimensions(53,176);
    S_buttonMercA.renderActive = 1;
    S_buttonMercA.isButton = 1;

    S_buttonNissan.renderType = S_buttonNissan.renderTypes::Objects;
    S_buttonNissan.buttonType = S_buttonNissan.buttonTypes::buttonNissan;
    S_buttonNissan.spriteName = "S_buttonNissan";
    S_buttonNissan.SetSpriteSheet(0);
    S_buttonNissan.SetIndex(770,578);
    S_buttonNissan.SetIndexDimensions(53,176);
    S_buttonNissan.SetDimensions(53,176);
    S_buttonNissan.renderActive = 1;
    S_buttonNissan.isButton = 1;
}

void MiscButtonSprites()
{
    using namespace rootNamespace;

    S_printButton.renderType = S_printButton.renderTypes::GUI;
    S_printButton.buttonType = S_printButton.buttonTypes::buttonPrint;
    S_printButton.spriteName = "S_printButton";
    S_printButton.SetSpriteSheet(0);
    S_printButton.SetIndex(502,835);
    S_printButton.SetIndexDimensions(41,150);
    S_printButton.SetStaticLocation(405,402);
    S_printButton.SetDimensions(41,150);
    S_printButton.renderActive = 1;
    S_printButton.isButton = 1;

    S_colourButton1.renderType = S_colourButton1.renderTypes::Objects;
    S_colourButton1.spriteName = "S_colourButton1";
    S_colourButton1.buttonType = S_colourButton1.buttonTypes::buttonColour1;
    S_colourButton1.SetSpriteSheet(0);
    S_colourButton1.SetIndex(960,579);
    S_colourButton1.SetIndexDimensions(21,23);
    S_colourButton1.SetDimensions(21,23);
    S_colourButton1.SetStaticLocation(372,367);
    S_colourButton1.renderActive = 1;
    S_colourButton1.isButton = 1;

    S_colourButton2.renderType = S_colourButton2.renderTypes::Objects;
    S_colourButton2.spriteName = "S_colourButton2";
    S_colourButton2.buttonType = S_colourButton2.buttonTypes::buttonColour2;
    S_colourButton2.SetSpriteSheet(0);
    S_colourButton2.SetIndex(960,579+29);
    S_colourButton2.SetIndexDimensions(21,23);
    S_colourButton2.SetDimensions(21,23);
    S_colourButton2.SetStaticLocation(372,367+29);
    S_colourButton2.renderActive = 1;
    S_colourButton2.isButton = 1;

    S_colourButton3.renderType = S_colourButton3.renderTypes::Objects;
    S_colourButton3.spriteName = "S_colourButton3";
    S_colourButton3.buttonType = S_colourButton3.buttonTypes::buttonColour3;
    S_colourButton3.SetSpriteSheet(0);
    S_colourButton3.SetIndex(960,579+29*2);
    S_colourButton3.SetIndexDimensions(21,23);
    S_colourButton3.SetDimensions(21,23);
    S_colourButton3.SetStaticLocation(372,367+29*2);
    S_colourButton3.renderActive = 1;
    S_colourButton3.isButton = 1;

    S_colourButton4.renderType = S_colourButton4.renderTypes::Objects;
    S_colourButton4.spriteName = "S_colourButton4";
    S_colourButton4.buttonType = S_colourButton4.buttonTypes::buttonColour4;
    S_colourButton4.SetSpriteSheet(0);
    S_colourButton4.SetIndex(960,579+29*3);
    S_colourButton4.SetIndexDimensions(21,23);
    S_colourButton4.SetDimensions(21,23);
    S_colourButton4.SetStaticLocation(372,367+29*3);
    S_colourButton4.renderActive = 1;
    S_colourButton4.isButton = 1;

    S_colourButton5.renderType = S_colourButton5.renderTypes::Objects;
    S_colourButton5.spriteName = "S_colourButton5";
    S_colourButton5.buttonType = S_colourButton5.buttonTypes::buttonColour5;
    S_colourButton5.SetSpriteSheet(0);
    S_colourButton5.SetIndex(960,579+29*4);
    S_colourButton5.SetIndexDimensions(21,23);
    S_colourButton5.SetDimensions(21,23);
    S_colourButton5.SetStaticLocation(372,367+29*4);
    S_colourButton5.renderActive = 1;
    S_colourButton5.isButton = 1;

    S_specialButton1.renderType = S_specialButton1.renderTypes::Objects;
    S_specialButton1.spriteName = "S_specialButton1";
    S_specialButton1.buttonType = S_specialButton1.buttonTypes::specialButton1;
    S_specialButton1.SetSpriteSheet(0);
    S_specialButton1.SetIndex(0,753);
    S_specialButton1.SetIndexDimensions(41,90);
    S_specialButton1.SetDimensions(41,90);
    S_specialButton1.SetStaticLocation(38,392);
    S_specialButton1.renderActive = 1;
    S_specialButton1.isButton = 1;

    S_specialButton2.renderType = S_specialButton2.renderTypes::Objects;
    S_specialButton2.spriteName = "S_specialButton2";
    S_specialButton2.buttonType = S_specialButton2.buttonTypes::specialButton2;
    S_specialButton2.SetSpriteSheet(0);
    S_specialButton2.SetIndex(90,753);
    S_specialButton2.SetIndexDimensions(41,99);
    S_specialButton2.SetDimensions(41,99);
    S_specialButton2.SetStaticLocation(137,392);
    S_specialButton2.renderActive = 1;
    S_specialButton2.isButton = 1;

    S_specialButton3.renderType = S_specialButton3.renderTypes::Objects;
    S_specialButton3.spriteName = "S_specialButton3";
    S_specialButton3.buttonType = S_specialButton3.buttonTypes::specialButton3;
    S_specialButton3.SetSpriteSheet(0);
    S_specialButton3.SetIndex(189,835);
    S_specialButton3.SetIndexDimensions(41,53);
    S_specialButton3.SetDimensions(41,53);
    S_specialButton3.SetStaticLocation(245,392);
    S_specialButton3.renderActive = 1;
    S_specialButton3.isButton = 1;

    S_specialButton4.renderType = S_specialButton4.renderTypes::Objects;
    S_specialButton4.spriteName = "S_specialButton4";
    S_specialButton4.buttonType = S_specialButton4.buttonTypes::specialButton4;
    S_specialButton4.SetSpriteSheet(0);
    S_specialButton4.SetIndex(242,835);
    S_specialButton4.SetIndexDimensions(41,140);
    S_specialButton4.SetDimensions(41,140);
    S_specialButton4.SetStaticLocation(38,442);
    S_specialButton4.renderActive = 1;
    S_specialButton4.isButton = 1;

    S_specialButton5.renderType = S_specialButton5.renderTypes::Objects;
    S_specialButton5.spriteName = "S_specialButton5";
    S_specialButton5.buttonType = S_specialButton5.buttonTypes::specialButton5;
    S_specialButton5.SetSpriteSheet(0);
    S_specialButton5.SetIndex(382,835);
    S_specialButton5.SetIndexDimensions(41,120);
    S_specialButton5.SetDimensions(41,120);
    S_specialButton5.SetStaticLocation(188,442);
    S_specialButton5.renderActive = 1;
    S_specialButton5.isButton = 1;
}

void SetExtrasButtons(int scene)
{
    using namespace rootNamespace;

    switch(scene)
    {
    case SCENE_ASTRA:
        S_specialButton1.suspendObject = 0;
        S_specialButton1.extraCost = 42785;

        S_specialButton2.suspendObject = 1;
        S_specialButton2.extraCost = 0;

        S_specialButton3.suspendObject = 0;
        S_specialButton3.extraCost = 9400;

        S_specialButton4.suspendObject = 1;
        S_specialButton4.extraCost = 0;

        S_specialButton5.suspendObject = 0;
        S_specialButton5.extraCost = 3998;
        break;

    case SCENE_MOKKA:
        S_specialButton1.suspendObject = 1;
        S_specialButton1.extraCost = 0;

        S_specialButton2.suspendObject = 1;
        S_specialButton2.extraCost = 0;

        S_specialButton3.suspendObject = 0;
        S_specialButton3.extraCost = 11500;

        S_specialButton4.suspendObject = 0;
        S_specialButton4.extraCost = 176920;

        S_specialButton5.suspendObject = 0;
        S_specialButton5.extraCost = 5670;
        break;

    case SCENE_BENZ_C:
        S_specialButton1.suspendObject = 1;
        S_specialButton1.extraCost = 0;

        S_specialButton2.suspendObject = 0;
        S_specialButton2.extraCost = 39997;

        S_specialButton3.suspendObject = 0;
        S_specialButton3.extraCost = 15500;

        S_specialButton4.suspendObject = 0;
        S_specialButton4.extraCost = 186920;

        S_specialButton5.suspendObject = 0;
        S_specialButton5.extraCost = 7670;
        break;

    case SCENE_BENZ_A:
        S_specialButton1.suspendObject = 0;
        S_specialButton1.extraCost = 96944;

        S_specialButton2.suspendObject = 0;
        S_specialButton2.extraCost = 49927;

        S_specialButton3.suspendObject = 0;
        S_specialButton3.extraCost = 22507;

        S_specialButton4.suspendObject = 0;
        S_specialButton4.extraCost = 201928;

        S_specialButton5.suspendObject = 0;
        S_specialButton5.extraCost = 9670;
        break;

    case SCENE_MICRA:
        S_specialButton1.suspendObject = 1;
        S_specialButton1.extraCost = 0;

        S_specialButton2.suspendObject = 0;
        S_specialButton2.extraCost = 23590;

        S_specialButton3.suspendObject = 1;
        S_specialButton3.extraCost = 0;

        S_specialButton4.suspendObject = 1;
        S_specialButton4.extraCost = 0;

        S_specialButton5.suspendObject = 1;
        S_specialButton5.extraCost = 0;
        break;
    }

    S_specialButton1.buttonFlipFlop = 0;
    S_specialButton2.buttonFlipFlop = 0;
    S_specialButton3.buttonFlipFlop = 0;
    S_specialButton4.buttonFlipFlop = 0;
    S_specialButton5.buttonFlipFlop = 0;
}

void CyclicalResets(void)
{
    using namespace rootNamespace;

    doSync = 0;
}
