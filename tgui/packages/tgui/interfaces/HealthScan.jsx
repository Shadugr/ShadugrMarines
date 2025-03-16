import { useBackend } from '../backend';
import {
  Box,
  Button,
  Divider,
  Flex,
  Icon,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
  Stack,
} from '../components';
import { Window } from '../layouts';

export const HealthScan = (props) => {
  const { act, data } = useBackend();
  const {
    patient_mob,
    patient,
    dead,
    health,
    total_brute,
    total_burn,
    toxin,
    oxy,
    clone,

    has_chemicals,
    limbs_damaged,

    damaged_organs,
    ssd,

    diseases,

    blood_type,
    blood_amount,
    has_blood,
    body_temperature,
    pulse,
    implants,
    core_fracture,
    lung_ruptured,
    hugged,
    detail_level,
    permadead,
    heart_broken,
    advice,
    species,
    holocard,
  } = data;

  const bloodpct = blood_amount / 560;

  const healthanalyser = detail_level < 1;
  const bodyscanner = detail_level >= 1;
  const ghostscan = detail_level >= 2;

  const Synthetic = species === 'Синтетик';

  const theme = Synthetic ? 'hackerman' : bodyscanner ? 'ntos' : 'default';

  let holocard_message;
  if (holocard === 'red') {
    holocard_message = 'Пациент нуждается в НЕОТЛОЖНОЙ медицинской помощи.';
  } else if (holocard === 'orange') {
    holocard_message = 'Пациенту нужна плановая хирургия.';
  } else if (holocard === 'purple') {
    holocard_message = 'Пациент заражён эмбрионом XX-121.';
  } else if (holocard === 'black') {
    holocard_message = 'Реанимация невозможна.';
  } else {
    holocard_message = 'У пациента нет активной голокарты.';
  }
  return (
    <Window width={500} height={bodyscanner ? 700 : 600} theme={theme}>
      <Window.Content scrollable>
        <Section title={'Пациент: ' + patient}>
          {hugged && ghostscan ? (
            <NoticeBox danger>Пациент заражён чужеродным эмбрионом!</NoticeBox>
          ) : null}
          {dead ? <NoticeBox danger>Пациент скончался!</NoticeBox> : null}
          {ssd ? (
            <NoticeBox warning color="grey">
              {ssd}
            </NoticeBox>
          ) : null}
          <LabeledList>
            <LabeledList.Item label="Здоровье">
              {health >= 0 ? (
                <ProgressBar
                  value={health / 100}
                  ranges={{
                    good: [0.7, Infinity],
                    average: [0.2, 0.7],
                    bad: [-Infinity, 0.2],
                  }}
                >
                  {health}%
                </ProgressBar>
              ) : (
                <ProgressBar
                  value={1 + health / 100}
                  ranges={{
                    bad: [-Infinity, Infinity],
                  }}
                >
                  {health}%
                </ProgressBar>
              )}
            </LabeledList.Item>
            {dead ? (
              <LabeledList.Item label="Состояние">
                <Box color={permadead ? 'red' : 'green'} bold={1}>
                  {permadead
                    ? heart_broken
                      ? 'Разрыв Миокарда, требуется хирургическое вмешательство'
                      : 'Реанимация невозможна.'
                    : Synthetic
                      ? 'Отключена центральная энергосистема, возможна перезагрузка'
                      : 'Остановка сердца, возможна реанимация.'}
                </Box>
              </LabeledList.Item>
            ) : null}
            <LabeledList.Item label="Урон">
              <Box inline>
                <ProgressBar>
                  Ушибы:{' '}
                  <Box inline bold color={'red'}>
                    {total_brute}
                  </Box>
                </ProgressBar>
              </Box>
              <Box inline width={'5px'} />
              <Box inline>
                <ProgressBar>
                  Ожоги:{' '}
                  <Box inline bold color={'#ffb833'}>
                    {total_burn}
                  </Box>
                </ProgressBar>
              </Box>
              <Box inline width={'5px'} />
              <Box inline>
                <ProgressBar>
                  Токсины:{' '}
                  <Box inline bold color={'green'}>
                    {toxin}
                  </Box>
                </ProgressBar>
              </Box>
              <Box inline width={'5px'} />
              <Box inline>
                <ProgressBar>
                  Гипоксия:{' '}
                  <Box inline bold color={'blue'}>
                    {oxy}
                  </Box>
                </ProgressBar>
              </Box>
              <Box inline width={'5px'} />
              {!!clone && (
                <Box inline>
                  <ProgressBar>
                    Мутации:{' '}
                    <Box inline color={'teal'}>
                      {clone}
                    </Box>
                  </ProgressBar>
                </Box>
              )}
            </LabeledList.Item>
            <LabeledList.Item label="Голокарта">
              <NoticeBox color={holocard} inline>
                {holocard_message}
              </NoticeBox>

              <Button
                inline
                style={{ marginLeft: '2%' }}
                onClick={() => act('change_holo_card')}
              >
                Изменить
              </Button>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        {limbs_damaged ? <ScannerLimbs /> : null}
        {has_chemicals ? <ScannerChems /> : null}
        {damaged_organs?.length && bodyscanner ? <ScannerOrgans /> : null}
        {diseases ? (
          <Section title="Болезни">
            <LabeledList>
              {diseases.map((disease) => (
                <LabeledList.Item
                  key={disease.name}
                  label={disease.name[0].toUpperCase() + disease.name.slice(1)}
                >
                  <Box inline bold={1}>
                    Тип : {disease.type}, возможное лечение: {disease.cure}
                  </Box>
                  <Box inline width={'5px'} />
                  <Box inline>
                    <ProgressBar
                      width="200px"
                      value={disease.stage / disease.max_stage}
                      ranges={{
                        good: [-Infinity, 20],
                        average: [20, 50],
                        bad: [50, Infinity],
                      }}
                    >
                      Стадия:{disease.stage}/{disease.max_stage}
                    </ProgressBar>
                  </Box>
                </LabeledList.Item>
              ))}
            </LabeledList>
          </Section>
        ) : null}
        <Section>
          <LabeledList>
            {has_blood ? (
              <LabeledList.Item label={'Группа крови ' + blood_type}>
                <Box
                  color={
                    bloodpct > 0.9 ? 'green' : bloodpct > 0.7 ? 'orange' : 'red'
                  }
                >
                  {Math.round(blood_amount / 5.6)}%, {blood_amount}cl
                </Box>
              </LabeledList.Item>
            ) : null}
            <LabeledList.Item label={'Температура тела'}>
              {body_temperature}
            </LabeledList.Item>
            <LabeledList.Item label={'Пульс'}>{pulse}</LabeledList.Item>
          </LabeledList>
          {implants ||
          hugged ||
          core_fracture ||
          (lung_ruptured && bodyscanner) ? (
            <Divider />
          ) : null}
          {implants && detail_level !== 1 ? (
            <NoticeBox danger>
              {implants} чужеродны{implants > 1 ? 'х' : 'й'}
              объект{implants > 1 ? 'а' : ''}!
              {healthanalyser
                ? ' Для обнаружения требуется продвинутый сканер.'
                : ''}
            </NoticeBox>
          ) : null}
          {(implants || hugged) && detail_level === 1 ? (
            <NoticeBox danger>
              {implants + (hugged ? 1 : 0)} чужеродны
              {implants + (hugged ? 1 : 0) > 1 ? 'х' : 'й'} объект
              {implants + (hugged ? 1 : 0) > 1 ? 'а' : ''}!
            </NoticeBox>
          ) : null}
          {lung_ruptured && bodyscanner ? (
            <NoticeBox danger>Обнаружен разрыв лёгкого!</NoticeBox>
          ) : null}
          {core_fracture && healthanalyser ? (
            <NoticeBox danger>
              Обнаружены переломы костей! Для обнаружения требуется продвинутый
              сканер.
            </NoticeBox>
          ) : null}
        </Section>
        {advice ? (
          <Section title="Медицинские рекомендации">
            <Stack vertical>
              {advice.map((advice) => (
                <Stack.Item key={advice.advice}>
                  <Box inline>
                    <Icon name={advice.icon} ml={0.2} color={advice.color} />
                    <Box inline width={'5px'} />
                    {advice.advice}
                  </Box>
                </Stack.Item>
              ))}
            </Stack>
          </Section>
        ) : null}
      </Window.Content>
    </Window>
  );
};

const ScannerChems = (props) => {
  const { data } = useBackend();
  const { has_unknown_chemicals, chemicals_lists } = data;
  const chemicals = Object.values(chemicals_lists);

  return (
    <Section title="Содержание химикатов">
      {has_unknown_chemicals ? (
        <NoticeBox warning color="grey">
          Обнаружены неизвестные химикаты.
        </NoticeBox>
      ) : null}
      <Stack vertical>
        {chemicals.map((chemical) => (
          <Stack.Item key={chemical.name}>
            <Box inline>
              <Icon name={'flask'} ml={0.2} color={chemical.color} />
              <Box inline width={'5px'} />
              <Box
                inline
                color={chemical.dangerous ? 'red' : 'white'}
                bold={chemical.dangerous}
              >
                {chemical.amount + 'u ' + chemical.name}
              </Box>
              <Box inline width={'5px'} />
              {chemical.od ? (
                <Box inline color={'red'} bold={1}>
                  {'OD'}
                </Box>
              ) : null}
            </Box>
          </Stack.Item>
        ))}
      </Stack>
    </Section>
  );
};

const ScannerLimbs = (props) => {
  const { data } = useBackend();
  const { limb_data_lists, detail_level } = data;
  const limb_data = Object.values(limb_data_lists);
  const bodyscanner = detail_level >= 1;

  let index = 0;
  const row_bg_color = 'rgba(255, 255, 255, .05)';

  limb_data.forEach((limb) => {
    limb.unbandaged = !limb.bandaged && limb.brute > 0 && !limb.limb_type;
    limb.unsalved = !limb.salved && limb.burn > 0 && !limb.limb_type;
  });

  return (
    <Section title="Повреждённые части тела">
      <Stack vertical fill>
        <Flex width="100%" height="20px">
          <Flex.Item basis="85px" />
          <Flex.Item basis="55px" bold color="red">
            Ушиб
          </Flex.Item>
          <Flex.Item basis="55px" bold color="#ffb833">
            Ожог
          </Flex.Item>
          <Flex.Item grow="1" shrink="1" textAlign="right" nowrap>
            {'{ } = Необработано'}
          </Flex.Item>
        </Flex>
        {limb_data.map((limb) => (
          <Flex
            key={limb.name}
            width="100%"
            minHeight="15px"
            py="3px"
            backgroundColor={index++ % 2 === 0 ? row_bg_color : ''}
          >
            <Flex.Item basis="85px" shrink="0" bold pl="3px">
              {limb.name[0].toUpperCase() + limb.name.slice(1)}
            </Flex.Item>
            {limb.missing ? (
              <Flex.Item color={'red'} bold={1}>
                ОТСУТСТВУЕТ
              </Flex.Item>
            ) : (
              <>
                <Flex.Item basis="fit-content" shrink="0">
                  <Box
                    inline
                    width="50px"
                    color={limb.brute > 0 ? 'red' : 'white'}
                  >
                    {limb.unbandaged ? `{${limb.brute}}` : `${limb.brute}`}
                  </Box>
                  <Box inline width="5px" />
                  <Box
                    inline
                    width="50px"
                    color={limb.burn > 0 ? '#ffb833' : 'white'}
                  >
                    {limb.unsalved ? `{${limb.burn}}` : `${limb.burn}`}
                  </Box>
                  <Box inline width="5px" />
                </Flex.Item>
                <Flex.Item shrink="1">
                  {limb.bleeding ? (
                    <Box inline color={'red'} bold={1}>
                      [Кровотечение]
                    </Box>
                  ) : null}
                  {limb.internal_bleeding ? (
                    <Box inline color={'red'} bold={1}>
                      [Внутреннее кровотечение]
                    </Box>
                  ) : null}
                  {limb.limb_status ? (
                    <Box
                      inline
                      color={
                        limb.limb_status === 'Перелом' || 'Возможен перелом'
                          ? 'white'
                          : 'red'
                      }
                      bold={1}
                    >
                      [{limb.limb_status}]
                    </Box>
                  ) : null}
                  {limb.limb_splint ? (
                    <Box inline color={'lime'} bold={1}>
                      [{limb.limb_splint}]
                    </Box>
                  ) : null}
                  {limb.limb_type ? (
                    <Box
                      inline
                      color={
                        limb.limb_type === 'Нефункционирующая Кибернетика'
                          ? 'red'
                          : 'green'
                      }
                      bold={1}
                    >
                      [{limb.limb_type}]
                    </Box>
                  ) : null}
                  {limb.open_incision ? (
                    <Box inline color={'red'} bold={1}>
                      [Открытый хирургический разрез]
                    </Box>
                  ) : null}
                  {limb.implant && bodyscanner ? (
                    <Box inline color={'white'} bold={1}>
                      [Чужеродный объект]
                    </Box>
                  ) : null}
                  {limb.open_zone_incision ? (
                    <Box inline color={'red'} bold={1}>
                      [Открытый хирургический разрез на{' '}
                      {limb.open_zone_incision}]
                    </Box>
                  ) : null}
                </Flex.Item>
              </>
            )}
          </Flex>
        ))}
      </Stack>
    </Section>
  );
};

const ScannerOrgans = (props) => {
  const { data } = useBackend();
  const { damaged_organs } = data;

  return (
    <Section title="Повреждения органов">
      <LabeledList>
        {damaged_organs.map((organ) => (
          <LabeledList.Item
            key={organ.name}
            label={organ.name[0].toUpperCase() + organ.name.slice(1)}
          >
            <Box
              inline
              color={organ.status === 'Ушиб' ? 'orange' : 'red'}
              bold={1}
            >
              {organ.status + ' [' + organ.damage + ' урон(а)]'}
            </Box>
            <Box inline width={'5px'} />
            {organ.robotic ? (
              <Box inline bold={1} color="blue">
                Кибернетика
              </Box>
            ) : null}
          </LabeledList.Item>
        ))}
      </LabeledList>
    </Section>
  );
};
