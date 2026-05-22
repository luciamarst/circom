#include <stdio.h>
#include <iostream>
#include <assert.h>
#include "circom.hpp"
#include "calcwit.hpp"
void ValidarTransicion_0_create(uint soffset,uint coffset,Circom_CalcWit* ctx,std::string componentName,uint componentFather);
void ValidarTransicion_0_run(uint ctx_index,Circom_CalcWit* ctx);
void MisionerosCanibales_1_create(uint soffset,uint coffset,Circom_CalcWit* ctx,std::string componentName,uint componentFather);
void MisionerosCanibales_1_run(uint ctx_index,Circom_CalcWit* ctx);
Circom_TemplateFunction _functionTable[2] = { 
ValidarTransicion_0_run,
MisionerosCanibales_1_run };
Circom_TemplateFunction _functionTableParallel[2] = { 
NULL,
NULL };
uint get_main_input_signal_start() {return 2;}

uint get_main_input_signal_no() {return 36;}

uint get_total_signal_no() {return 1545;}

uint get_number_of_components() {return 12;}

uint get_size_of_input_hashmap() {return 256;}

uint get_size_of_witness() {return 1545;}

uint get_size_of_constants() {return 5;}

uint get_size_of_io_map() {return 0;}

uint get_size_of_bus_field_map() {return 0;}

void release_memory_component(Circom_CalcWit* ctx, uint pos) {{

if (pos != 0){{

if(ctx->componentMemory[pos].subcomponents)
delete []ctx->componentMemory[pos].subcomponents;

if(ctx->componentMemory[pos].subcomponentsParallel)
delete []ctx->componentMemory[pos].subcomponentsParallel;

if(ctx->componentMemory[pos].outputIsSet)
delete []ctx->componentMemory[pos].outputIsSet;

if(ctx->componentMemory[pos].mutexes)
delete []ctx->componentMemory[pos].mutexes;

if(ctx->componentMemory[pos].cvs)
delete []ctx->componentMemory[pos].cvs;

if(ctx->componentMemory[pos].sbct)
delete []ctx->componentMemory[pos].sbct;

}}


}}


// function declarations
// template declarations
void ValidarTransicion_0_create(uint soffset,uint coffset,Circom_CalcWit* ctx,std::string componentName,uint componentFather){
ctx->componentMemory[coffset].templateId = 0;
ctx->componentMemory[coffset].templateName = "ValidarTransicion";
ctx->componentMemory[coffset].signalStart = soffset;
ctx->componentMemory[coffset].inputCounter = 6;
ctx->componentMemory[coffset].componentName = componentName;
ctx->componentMemory[coffset].idFather = componentFather;
ctx->componentMemory[coffset].subcomponents = new uint[0];
}

void ValidarTransicion_0_run(uint ctx_index,Circom_CalcWit* ctx){
FrElement* circuitConstants = ctx->circuitConstants;
FrElement* signalValues = ctx->signalValues;
FrElement expaux[5];
FrElement lvar[3];
u64 mySignalStart = ctx->componentMemory[ctx_index].signalStart;
std::string myTemplateName = ctx->componentMemory[ctx_index].templateName;
std::string myComponentName = ctx->componentMemory[ctx_index].componentName;
u64 myFather = ctx->componentMemory[ctx_index].idFather;
u64 myId = ctx_index;
u32* mySubcomponents = ctx->componentMemory[ctx_index].subcomponents;
bool* mySubcomponentsParallel = ctx->componentMemory[ctx_index].subcomponentsParallel;
std::string* listOfTemplateMessages = ctx->listOfTemplateMessages;
uint sub_component_aux;
uint index_multiple_eq;
int cmp_index_ref_load = -1;
{
PFrElement aux_dest = &signalValues[mySignalStart + 7];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[0]);
}
{{
Fr_eq(&expaux[1],&signalValues[mySignalStart + 3],&circuitConstants[0]); // line circom 35
}}
Fr_neq(&expaux[2],&signalValues[mySignalStart + 6],&circuitConstants[1]); // line circom 35
Fr_land(&expaux[0],&expaux[1],&expaux[2]); // line circom 35
if(Fr_isTrue(&expaux[0])){
{
PFrElement aux_dest = &signalValues[mySignalStart + 8];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[1]);
}
}else{
{
PFrElement aux_dest = &signalValues[mySignalStart + 8];
// load src
// end load src
Fr_copy(aux_dest,&signalValues[mySignalStart + 7]);
}
}
{{
Fr_eq(&expaux[1],&signalValues[mySignalStart + 3],&circuitConstants[1]); // line circom 41
}}
Fr_neq(&expaux[2],&signalValues[mySignalStart + 6],&circuitConstants[0]); // line circom 41
Fr_land(&expaux[0],&expaux[1],&expaux[2]); // line circom 41
if(Fr_isTrue(&expaux[0])){
{
PFrElement aux_dest = &signalValues[mySignalStart + 9];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[1]);
}
}else{
{
PFrElement aux_dest = &signalValues[mySignalStart + 9];
// load src
// end load src
Fr_copy(aux_dest,&signalValues[mySignalStart + 8]);
}
}
{
PFrElement aux_dest = &signalValues[mySignalStart + 27];
// load src
Fr_sub(&expaux[2],&signalValues[mySignalStart + 1],&signalValues[mySignalStart + 4]); // line circom 51
Fr_mul(&expaux[1],&signalValues[mySignalStart + 3],&expaux[2]); // line circom 51
Fr_sub(&expaux[3],&circuitConstants[0],&signalValues[mySignalStart + 3]); // line circom 51
Fr_sub(&expaux[4],&signalValues[mySignalStart + 4],&signalValues[mySignalStart + 1]); // line circom 51
Fr_mul(&expaux[2],&expaux[3],&expaux[4]); // line circom 51
Fr_add(&expaux[0],&expaux[1],&expaux[2]); // line circom 51
// end load src
Fr_copy(aux_dest,&expaux[0]);
}
{
PFrElement aux_dest = &signalValues[mySignalStart + 28];
// load src
Fr_sub(&expaux[2],&signalValues[mySignalStart + 2],&signalValues[mySignalStart + 5]); // line circom 52
Fr_mul(&expaux[1],&signalValues[mySignalStart + 3],&expaux[2]); // line circom 52
Fr_sub(&expaux[3],&circuitConstants[0],&signalValues[mySignalStart + 3]); // line circom 52
Fr_sub(&expaux[4],&signalValues[mySignalStart + 5],&signalValues[mySignalStart + 2]); // line circom 52
Fr_mul(&expaux[2],&expaux[3],&expaux[4]); // line circom 52
Fr_add(&expaux[0],&expaux[1],&expaux[2]); // line circom 52
// end load src
Fr_copy(aux_dest,&expaux[0]);
}
{
PFrElement aux_dest = &lvar[0];
// load src
Fr_add(&expaux[0],&signalValues[mySignalStart + 27],&signalValues[mySignalStart + 28]); // line circom 56
// end load src
Fr_copy(aux_dest,&expaux[0]);
}
Fr_lt(&expaux[1],&lvar[0],&circuitConstants[0]); // line circom 57
Fr_gt(&expaux[2],&lvar[0],&circuitConstants[2]); // line circom 57
Fr_lor(&expaux[0],&expaux[1],&expaux[2]); // line circom 57
if(Fr_isTrue(&expaux[0])){
{
PFrElement aux_dest = &signalValues[mySignalStart + 10];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[1]);
}
}else{
{
PFrElement aux_dest = &signalValues[mySignalStart + 10];
// load src
// end load src
Fr_copy(aux_dest,&signalValues[mySignalStart + 9]);
}
}
Fr_lt(&expaux[0],&signalValues[mySignalStart + 27],&circuitConstants[1]); // line circom 64
if(Fr_isTrue(&expaux[0])){
{
PFrElement aux_dest = &signalValues[mySignalStart + 11];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[1]);
}
}else{
{
PFrElement aux_dest = &signalValues[mySignalStart + 11];
// load src
// end load src
Fr_copy(aux_dest,&signalValues[mySignalStart + 10]);
}
}
Fr_lt(&expaux[0],&signalValues[mySignalStart + 28],&circuitConstants[1]); // line circom 70
if(Fr_isTrue(&expaux[0])){
{
PFrElement aux_dest = &signalValues[mySignalStart + 12];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[1]);
}
}else{
{
PFrElement aux_dest = &signalValues[mySignalStart + 12];
// load src
// end load src
Fr_copy(aux_dest,&signalValues[mySignalStart + 11]);
}
}
Fr_gt(&expaux[1],&signalValues[mySignalStart + 4],&circuitConstants[1]); // line circom 78
Fr_lt(&expaux[2],&signalValues[mySignalStart + 4],&signalValues[mySignalStart + 5]); // line circom 78
Fr_land(&expaux[0],&expaux[1],&expaux[2]); // line circom 78
if(Fr_isTrue(&expaux[0])){
{
PFrElement aux_dest = &signalValues[mySignalStart + 13];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[1]);
}
}else{
{
PFrElement aux_dest = &signalValues[mySignalStart + 13];
// load src
// end load src
Fr_copy(aux_dest,&signalValues[mySignalStart + 12]);
}
}
{
PFrElement aux_dest = &lvar[1];
// load src
Fr_sub(&expaux[0],&circuitConstants[3],&signalValues[mySignalStart + 4]); // line circom 85
// end load src
Fr_copy(aux_dest,&expaux[0]);
}
{
PFrElement aux_dest = &lvar[2];
// load src
Fr_sub(&expaux[0],&circuitConstants[3],&signalValues[mySignalStart + 5]); // line circom 86
// end load src
Fr_copy(aux_dest,&expaux[0]);
}
Fr_gt(&expaux[1],&lvar[1],&circuitConstants[1]); // line circom 87
Fr_lt(&expaux[2],&lvar[1],&lvar[2]); // line circom 87
Fr_land(&expaux[0],&expaux[1],&expaux[2]); // line circom 87
if(Fr_isTrue(&expaux[0])){
{
PFrElement aux_dest = &signalValues[mySignalStart + 14];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[1]);
}
}else{
{
PFrElement aux_dest = &signalValues[mySignalStart + 14];
// load src
// end load src
Fr_copy(aux_dest,&signalValues[mySignalStart + 13]);
}
}
Fr_lt(&expaux[1],&signalValues[mySignalStart + 4],&circuitConstants[1]); // line circom 94
Fr_gt(&expaux[2],&signalValues[mySignalStart + 4],&circuitConstants[3]); // line circom 94
Fr_lor(&expaux[0],&expaux[1],&expaux[2]); // line circom 94
if(Fr_isTrue(&expaux[0])){
{
PFrElement aux_dest = &signalValues[mySignalStart + 15];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[1]);
}
}else{
{
PFrElement aux_dest = &signalValues[mySignalStart + 15];
// load src
// end load src
Fr_copy(aux_dest,&signalValues[mySignalStart + 14]);
}
}
Fr_lt(&expaux[1],&signalValues[mySignalStart + 5],&circuitConstants[1]); // line circom 100
Fr_gt(&expaux[2],&signalValues[mySignalStart + 5],&circuitConstants[3]); // line circom 100
Fr_lor(&expaux[0],&expaux[1],&expaux[2]); // line circom 100
if(Fr_isTrue(&expaux[0])){
{
PFrElement aux_dest = &signalValues[mySignalStart + 16];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[1]);
}
}else{
{
PFrElement aux_dest = &signalValues[mySignalStart + 16];
// load src
// end load src
Fr_copy(aux_dest,&signalValues[mySignalStart + 15]);
}
}
{
PFrElement aux_dest = &signalValues[mySignalStart + 0];
// load src
// end load src
Fr_copy(aux_dest,&signalValues[mySignalStart + 16]);
}
for (uint i = 0; i < 0; i++){
uint index_subc = ctx->componentMemory[ctx_index].subcomponents[i];
if (index_subc != 0)release_memory_component(ctx,index_subc);
}
}

void MisionerosCanibales_1_create(uint soffset,uint coffset,Circom_CalcWit* ctx,std::string componentName,uint componentFather){
ctx->componentMemory[coffset].templateId = 1;
ctx->componentMemory[coffset].templateName = "MisionerosCanibales";
ctx->componentMemory[coffset].signalStart = soffset;
ctx->componentMemory[coffset].inputCounter = 36;
ctx->componentMemory[coffset].componentName = componentName;
ctx->componentMemory[coffset].idFather = componentFather;
ctx->componentMemory[coffset].subcomponents = new uint[11]{0};
}

void MisionerosCanibales_1_run(uint ctx_index,Circom_CalcWit* ctx){
FrElement* circuitConstants = ctx->circuitConstants;
FrElement* signalValues = ctx->signalValues;
FrElement expaux[5];
FrElement lvar[1];
u64 mySignalStart = ctx->componentMemory[ctx_index].signalStart;
std::string myTemplateName = ctx->componentMemory[ctx_index].templateName;
std::string myComponentName = ctx->componentMemory[ctx_index].componentName;
u64 myFather = ctx->componentMemory[ctx_index].idFather;
u64 myId = ctx_index;
u32* mySubcomponents = ctx->componentMemory[ctx_index].subcomponents;
bool* mySubcomponentsParallel = ctx->componentMemory[ctx_index].subcomponentsParallel;
std::string* listOfTemplateMessages = ctx->listOfTemplateMessages;
uint sub_component_aux;
uint index_multiple_eq;
int cmp_index_ref_load = -1;
{
uint aux_create = 0;
int aux_cmp_num = 0+ctx_index+1;
uint csoffset = mySignalStart+70;
uint aux_dimensions[1] = {11};
for (uint i = 0; i < 11; i++) {
std::string new_cmp_name = "validador"+ctx->generate_position_array(aux_dimensions, 1, i);
ValidarTransicion_0_create(csoffset,aux_cmp_num,ctx,new_cmp_name,myId);
mySubcomponents[aux_create+ i] = aux_cmp_num;
csoffset += 134 ;
aux_cmp_num += 1;
}
}
{
{{
Fr_eq(&expaux[0],&signalValues[mySignalStart + 1],&circuitConstants[3]); // line circom 120
}}
if (!Fr_isTrue(&expaux[0])) std::cout << "Failed assert in template/function " << myTemplateName << " line 120. " <<  "Followed trace of components: " << ctx->getTrace(myId) << std::endl;
assert(Fr_isTrue(&expaux[0]));
}
{
{{
Fr_eq(&expaux[0],&signalValues[mySignalStart + 2],&circuitConstants[3]); // line circom 121
}}
if (!Fr_isTrue(&expaux[0])) std::cout << "Failed assert in template/function " << myTemplateName << " line 121. " <<  "Followed trace of components: " << ctx->getTrace(myId) << std::endl;
assert(Fr_isTrue(&expaux[0]));
}
{
{{
Fr_eq(&expaux[0],&signalValues[mySignalStart + 3],&circuitConstants[0]); // line circom 122
}}
if (!Fr_isTrue(&expaux[0])) std::cout << "Failed assert in template/function " << myTemplateName << " line 122. " <<  "Followed trace of components: " << ctx->getTrace(myId) << std::endl;
assert(Fr_isTrue(&expaux[0]));
}
{
PFrElement aux_dest = &signalValues[mySignalStart + 37];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[0]);
}
{
PFrElement aux_dest = &lvar[0];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[1]);
}
Fr_lt(&expaux[0],&lvar[0],&circuitConstants[4]); // line circom 129
while(Fr_isTrue(&expaux[0])){
{
uint cmp_index_ref = ((1 * Fr_toInt(&lvar[0])) + 0);
{
PFrElement aux_dest = &ctx->signalValues[ctx->componentMemory[mySubcomponents[cmp_index_ref]].signalStart + 1];
// load src
// end load src
Fr_copy(aux_dest,&signalValues[mySignalStart + (((3 * Fr_toInt(&lvar[0])) + 0) + 1)]);
}
// run sub component if needed
if(!(ctx->componentMemory[mySubcomponents[cmp_index_ref]].inputCounter -= 1)){
ValidarTransicion_0_run(mySubcomponents[cmp_index_ref],ctx);

}
}
{
uint cmp_index_ref = ((1 * Fr_toInt(&lvar[0])) + 0);
{
PFrElement aux_dest = &ctx->signalValues[ctx->componentMemory[mySubcomponents[cmp_index_ref]].signalStart + 2];
// load src
// end load src
Fr_copy(aux_dest,&signalValues[mySignalStart + (((3 * Fr_toInt(&lvar[0])) + 1) + 1)]);
}
// run sub component if needed
if(!(ctx->componentMemory[mySubcomponents[cmp_index_ref]].inputCounter -= 1)){
ValidarTransicion_0_run(mySubcomponents[cmp_index_ref],ctx);

}
}
{
uint cmp_index_ref = ((1 * Fr_toInt(&lvar[0])) + 0);
{
PFrElement aux_dest = &ctx->signalValues[ctx->componentMemory[mySubcomponents[cmp_index_ref]].signalStart + 3];
// load src
// end load src
Fr_copy(aux_dest,&signalValues[mySignalStart + (((3 * Fr_toInt(&lvar[0])) + 2) + 1)]);
}
// run sub component if needed
if(!(ctx->componentMemory[mySubcomponents[cmp_index_ref]].inputCounter -= 1)){
ValidarTransicion_0_run(mySubcomponents[cmp_index_ref],ctx);

}
}
{
uint cmp_index_ref = ((1 * Fr_toInt(&lvar[0])) + 0);
{
PFrElement aux_dest = &ctx->signalValues[ctx->componentMemory[mySubcomponents[cmp_index_ref]].signalStart + 4];
// load src
// end load src
Fr_copy(aux_dest,&signalValues[mySignalStart + (((3 * (Fr_toInt(&lvar[0]) + 1)) + 0) + 1)]);
}
// run sub component if needed
if(!(ctx->componentMemory[mySubcomponents[cmp_index_ref]].inputCounter -= 1)){
ValidarTransicion_0_run(mySubcomponents[cmp_index_ref],ctx);

}
}
{
uint cmp_index_ref = ((1 * Fr_toInt(&lvar[0])) + 0);
{
PFrElement aux_dest = &ctx->signalValues[ctx->componentMemory[mySubcomponents[cmp_index_ref]].signalStart + 5];
// load src
// end load src
Fr_copy(aux_dest,&signalValues[mySignalStart + (((3 * (Fr_toInt(&lvar[0]) + 1)) + 1) + 1)]);
}
// run sub component if needed
if(!(ctx->componentMemory[mySubcomponents[cmp_index_ref]].inputCounter -= 1)){
ValidarTransicion_0_run(mySubcomponents[cmp_index_ref],ctx);

}
}
{
uint cmp_index_ref = ((1 * Fr_toInt(&lvar[0])) + 0);
{
PFrElement aux_dest = &ctx->signalValues[ctx->componentMemory[mySubcomponents[cmp_index_ref]].signalStart + 6];
// load src
// end load src
Fr_copy(aux_dest,&signalValues[mySignalStart + (((3 * (Fr_toInt(&lvar[0]) + 1)) + 2) + 1)]);
}
// run sub component if needed
if(!(ctx->componentMemory[mySubcomponents[cmp_index_ref]].inputCounter -= 1)){
ValidarTransicion_0_run(mySubcomponents[cmp_index_ref],ctx);

}
}
{
PFrElement aux_dest = &signalValues[mySignalStart + ((1 * (Fr_toInt(&lvar[0]) + 1)) + 37)];
// load src
cmp_index_ref_load = ((1 * Fr_toInt(&lvar[0])) + 0);
cmp_index_ref_load = ((1 * Fr_toInt(&lvar[0])) + 0);
Fr_mul(&expaux[0],&signalValues[mySignalStart + ((1 * Fr_toInt(&lvar[0])) + 37)],&ctx->signalValues[ctx->componentMemory[mySubcomponents[((1 * Fr_toInt(&lvar[0])) + 0)]].signalStart + 0]); // line circom 143
// end load src
Fr_copy(aux_dest,&expaux[0]);
}
{
PFrElement aux_dest = &lvar[0];
// load src
Fr_add(&expaux[0],&lvar[0],&circuitConstants[0]); // line circom 129
// end load src
Fr_copy(aux_dest,&expaux[0]);
}
Fr_lt(&expaux[0],&lvar[0],&circuitConstants[4]); // line circom 129
}
Fr_neq(&expaux[2],&signalValues[mySignalStart + 34],&circuitConstants[1]); // line circom 148
Fr_neq(&expaux[3],&signalValues[mySignalStart + 35],&circuitConstants[1]); // line circom 148
Fr_lor(&expaux[1],&expaux[2],&expaux[3]); // line circom 148
Fr_neq(&expaux[2],&signalValues[mySignalStart + 36],&circuitConstants[1]); // line circom 148
Fr_lor(&expaux[0],&expaux[1],&expaux[2]); // line circom 148
if(Fr_isTrue(&expaux[0])){
{
PFrElement aux_dest = &signalValues[mySignalStart + 60];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[1]);
}
}else{
{
PFrElement aux_dest = &signalValues[mySignalStart + 60];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[0]);
}
}
{
PFrElement aux_dest = &signalValues[mySignalStart + 0];
// load src
Fr_mul(&expaux[0],&signalValues[mySignalStart + 48],&signalValues[mySignalStart + 60]); // line circom 155
// end load src
Fr_copy(aux_dest,&expaux[0]);
}
for (uint i = 0; i < 11; i++){
uint index_subc = ctx->componentMemory[ctx_index].subcomponents[i];
if (index_subc != 0)release_memory_component(ctx,index_subc);
}
}

void run(Circom_CalcWit* ctx){
MisionerosCanibales_1_create(1,0,ctx,"main",0);
MisionerosCanibales_1_run(0,ctx);
}

