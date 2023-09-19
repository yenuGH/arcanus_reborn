import 'package:arcanus_reborn/constants/enums.dart';
import 'package:arcanus_reborn/controllers/blocs/media_view/media_view_bloc.dart';
import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/models/media_list_result.dart';
import 'package:arcanus_reborn/widgets/media_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MangaView extends StatefulWidget {
  const MangaView({super.key, required this.mediaListStatus});

  final MediaListStatus mediaListStatus;

  @override
  State<MangaView> createState() => _MangaViewState();
}

class _MangaViewState extends State<MangaView> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MediaViewBloc>(context).add(MediaViewInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    List<MediaListResult> mangaList = AnilistClient().getUserMangaList(widget.mediaListStatus);

    return BlocConsumer<MediaViewBloc, MediaViewState>(
      listener:(_, state) {
        //log("State: ${state.runtimeType}");
        switch (state.runtimeType) {
          case (MediaViewInitialState): {
            mangaList = AnilistClient().getUserMangaList(widget.mediaListStatus);
            break;
          }
          case (MediaViewReloadedState): {
            BlocProvider.of<MediaViewBloc>(context).add(MediaViewUpdateEvent());
            break;
          }
          default: {
            mangaList = AnilistClient().getUserMangaList(widget.mediaListStatus);
            break;
          }
        }  
      },
      builder: (_, state) {
        switch (state.runtimeType) {
          case (MediaViewReloadingState):
          {
            return const CircularProgressIndicator();
          }
          case (MediaViewInitialState || MediaViewUpdateState):
          {
            if (mangaList.isEmpty){
              return const Text("No manga found.");
            }

            return ListView.builder(
              itemCount: mangaList.length,
              itemBuilder: (context, index) {
                return MediaListCard(mediaResult: mangaList[index]);
              },
            );
          }
          case (MediaViewErrorState): {
            return const Text("Error has occured, please restart the app.");
          }
          default:
          {
            return Container(
              alignment: Alignment.center,
              child: const Center(
                child: CircularProgressIndicator()
              )
            );
          }
        }
      },
    );
  }
}
