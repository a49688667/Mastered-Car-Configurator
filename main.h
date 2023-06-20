#ifndef MAIN_H_INCLUDED
#define MAIN_H_INCLUDED

#include <SDL.h>
#include <SDL_image.h>
#include <stdio.h>
#include <time.h>
#include <random>
#include <sprites.h>

void InputEvents(const Uint8 *P_KEYSTATE);
void Initialise(void);
void Destruct(void);
void RenderScene(SDL_Renderer *renderer);
int Ticker(int i, int mode);
int RandomNumber(int lowest, int highest);
void InitialiseSprites(void);
void ProgramEvents(void);
void ProgramState(void);
void CyclicalResets(void);
void PriceGraphicParser(void);
int SyncClock(Uint64 syncValue);
void MouseState();
void ButtonEventChecker(int i);
void CarButtonSprites();
void MiscButtonSprites();
void SetExtrasButtons(int scene);
void SceneAstra();
void SceneMokka();
void SceneBenzC();
void SceneBenzA();
void SceneNissan();

int SCREEN_HEIGHT;
int SCREEN_WIDTH;

int globalSyncValue = 1000/60;
int timeInitAccess = 0;
int timeStartStamp = 0;
int doSync = 0;

SDL_Event event;
SDL_bool quit;

int controllerVar_PS = 0;
int controllerVar_MLB = 0;
int progstate = -1;
enum progStates
{
    TITLESCREEN,
    SCENE_CHOOSE,
    SCENE_ASTRA,
    SCENE_MOKKA,
    SCENE_BENZ_C,
    SCENE_BENZ_A,
    SCENE_MICRA
};

//rendering..
SDL_Window* window;
SDL_Renderer* renderer;

//input..
const Uint8 *P_KEYSTATE = SDL_GetKeyboardState(NULL);
int mouseX, mouseY;
Uint32 mouseButtonState;

#endif // MAIN_H_INCLUDED
