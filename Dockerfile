FROM golang:1.23.4-bookworm AS build
WORKDIR /src
COPY src/ ./
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -ldflags="-s -w" -o /out/bot .

FROM scratch
COPY --from=build /out/bot /bot
ENV WD_P="g.lethal_k=0.7,hunt.hp_weight=0.18,scout.laser_r=240,guard.pref_laser=120,g.early_gunned_s=60,g.watch=2,g.fight_boost=15,g.dodge_boost=10,g.final_heal=0.9,g.mend_hp=0.7,g.early_solo_s=60,g.mend_quiet=2.5,g.mend_hold=1,g.post_keep=150,g.post_depth=0.6,g.busy_r=130,g.hurt_r=130,g.boost_charge=1,guard.loot_r=150,guard.cube_fight_r=70,g.cube_v=125,guard.laser_r=240,g.laser_v=250"
ENTRYPOINT ["/bot"]
