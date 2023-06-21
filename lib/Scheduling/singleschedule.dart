

class SingleTournament{

   setBye(List team){
    int count= team.length;

    if(count<4){
      team.add("bye");
    }
    return team;
  }

  
}