class WalletList {
  int total;
  String perPage;
  int currentPage;
  int lastPage;
  List<Data> data;
  int status;

  WalletList(
      {this.total,
      this.perPage,
      this.currentPage,
      this.lastPage,
      this.data,
      this.status});

  WalletList.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int cardid;
  int type;
  String nickname;
  String name;
  int mnemonic;

  Data({this.cardid, this.type, this.nickname, this.name, this.mnemonic});

  Data.fromJson(Map<String, dynamic> json) {
    cardid = json['cardid'];
    type = json['type'];
    nickname = json['nickname'];
    name = json['name'];
    mnemonic = json['mnemonic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardid'] = this.cardid;
    data['type'] = this.type;
    data['nickname'] = this.nickname;
    data['name'] = this.name;
    data['mnemonic'] = this.mnemonic;
    return data;
  }
}


class CurrentWalletInfo {
  int status;
  Info info;
  List<String> balances;
  String nickname;

  CurrentWalletInfo({this.status, this.info, this.balances, this.nickname});

  CurrentWalletInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    balances = json['balances'].cast<String>();
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    data['balances'] = this.balances;
    data['nickname'] = this.nickname;
    return data;
  }
}

class Info {
  String accountName;
  int headBlockNum;
  String headBlockTime;
  bool privileged;
  String lastCodeUpdate;
  String created;
  String coreLiquidBalance;
  int ramQuota;
  int netWeight;
  int cpuWeight;
  NetLimit netLimit;
  NetLimit cpuLimit;
  int ramUsage;
  List<Permissions> permissions;
  TotalResources totalResources;
  SelfDelegatedBandwidth selfDelegatedBandwidth;
  Null refundRequest;
  VoterInfo voterInfo;

  Info(
      {this.accountName,
      this.headBlockNum,
      this.headBlockTime,
      this.privileged,
      this.lastCodeUpdate,
      this.created,
      this.coreLiquidBalance,
      this.ramQuota,
      this.netWeight,
      this.cpuWeight,
      this.netLimit,
      this.cpuLimit,
      this.ramUsage,
      this.permissions,
      this.totalResources,
      this.selfDelegatedBandwidth,
      this.refundRequest,
      this.voterInfo});

  Info.fromJson(Map<String, dynamic> json) {
    accountName = json['account_name'];
    headBlockNum = json['head_block_num'];
    headBlockTime = json['head_block_time'];
    privileged = json['privileged'];
    lastCodeUpdate = json['last_code_update'];
    created = json['created'];
    coreLiquidBalance = json['core_liquid_balance'];
    ramQuota = json['ram_quota'];
    netWeight = json['net_weight'];
    cpuWeight = json['cpu_weight'];
    netLimit = json['net_limit'] != null
        ? new NetLimit.fromJson(json['net_limit'])
        : null;
    cpuLimit = json['cpu_limit'] != null
        ? new NetLimit.fromJson(json['cpu_limit'])
        : null;
    ramUsage = json['ram_usage'];
    if (json['permissions'] != null) {
      permissions = new List<Permissions>();
      json['permissions'].forEach((v) {
        permissions.add(new Permissions.fromJson(v));
      });
    }
    totalResources = json['total_resources'] != null
        ? new TotalResources.fromJson(json['total_resources'])
        : null;
    selfDelegatedBandwidth = json['self_delegated_bandwidth'] != null
        ? new SelfDelegatedBandwidth.fromJson(json['self_delegated_bandwidth'])
        : null;
    refundRequest = json['refund_request'];
    voterInfo = json['voter_info'] != null
        ? new VoterInfo.fromJson(json['voter_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_name'] = this.accountName;
    data['head_block_num'] = this.headBlockNum;
    data['head_block_time'] = this.headBlockTime;
    data['privileged'] = this.privileged;
    data['last_code_update'] = this.lastCodeUpdate;
    data['created'] = this.created;
    data['core_liquid_balance'] = this.coreLiquidBalance;
    data['ram_quota'] = this.ramQuota;
    data['net_weight'] = this.netWeight;
    data['cpu_weight'] = this.cpuWeight;
    if (this.netLimit != null) {
      data['net_limit'] = this.netLimit.toJson();
    }
    if (this.cpuLimit != null) {
      data['cpu_limit'] = this.cpuLimit.toJson();
    }
    data['ram_usage'] = this.ramUsage;
    if (this.permissions != null) {
      data['permissions'] = this.permissions.map((v) => v.toJson()).toList();
    }
    if (this.totalResources != null) {
      data['total_resources'] = this.totalResources.toJson();
    }
    if (this.selfDelegatedBandwidth != null) {
      data['self_delegated_bandwidth'] = this.selfDelegatedBandwidth.toJson();
    }
    data['refund_request'] = this.refundRequest;
    if (this.voterInfo != null) {
      data['voter_info'] = this.voterInfo.toJson();
    }
    return data;
  }
}

class NetLimit {
  int used;
  int available;
  int max;

  NetLimit({this.used, this.available, this.max});

  NetLimit.fromJson(Map<String, dynamic> json) {
    used = json['used'];
    available = json['available'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['used'] = this.used;
    data['available'] = this.available;
    data['max'] = this.max;
    return data;
  }
}

class Permissions {
  String permName;
  String parent;
  RequiredAuth requiredAuth;

  Permissions({this.permName, this.parent, this.requiredAuth});

  Permissions.fromJson(Map<String, dynamic> json) {
    permName = json['perm_name'];
    parent = json['parent'];
    requiredAuth = json['required_auth'] != null
        ? new RequiredAuth.fromJson(json['required_auth'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['perm_name'] = this.permName;
    data['parent'] = this.parent;
    if (this.requiredAuth != null) {
      data['required_auth'] = this.requiredAuth.toJson();
    }
    return data;
  }
}

class RequiredAuth {
  int threshold;
  List<Keys> keys;
  List<Accounts> accounts;
  List<Waits> waits;

  RequiredAuth({this.threshold, this.keys, this.accounts, this.waits});

  RequiredAuth.fromJson(Map<String, dynamic> json) {
    threshold = json['threshold'];
    if (json['keys'] != null) {
      keys = new List<Keys>();
      json['keys'].forEach((v) {
        keys.add(new Keys.fromJson(v));
      });
    }
    if (json['accounts'] != null) {
      accounts = new List<Accounts>();
      json['accounts'].forEach((v) {
        accounts.add(new Accounts.fromJson(v));
      });
    }
    if (json['waits'] != null) {
      waits = new List<Waits>();
      json['waits'].forEach((v) {
        waits.add(new Waits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['threshold'] = this.threshold;
    if (this.keys != null) {
      data['keys'] = this.keys.map((v) => v.toJson()).toList();
    }
    if (this.accounts != null) {
      data['accounts'] = this.accounts.map((v) => v.toJson()).toList();
    }
    if (this.waits != null) {
      data['waits'] = this.waits.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Keys {
  String key;
  int weight;

  Keys({this.key, this.weight});

  Keys.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['weight'] = this.weight;
    return data;
  }
}

class Accounts {
  Permission permission;
  int weight;

  Accounts({this.permission, this.weight});

  Accounts.fromJson(Map<String, dynamic> json) {
    permission = json['permission'] != null
        ? new Permission.fromJson(json['permission'])
        : null;
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.permission != null) {
      data['permission'] = this.permission.toJson();
    }
    data['weight'] = this.weight;
    return data;
  }
}

class Permission {
  String actor;
  String permission;

  Permission({this.actor, this.permission});

  Permission.fromJson(Map<String, dynamic> json) {
    actor = json['actor'];
    permission = json['permission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actor'] = this.actor;
    data['permission'] = this.permission;
    return data;
  }
}

class Waits {
  String name;

  Waits({this.name});

  Waits.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class TotalResources {
  String owner;
  String netWeight;
  String cpuWeight;
  int ramBytes;

  TotalResources({this.owner, this.netWeight, this.cpuWeight, this.ramBytes});

  TotalResources.fromJson(Map<String, dynamic> json) {
    owner = json['owner'];
    netWeight = json['net_weight'];
    cpuWeight = json['cpu_weight'];
    ramBytes = json['ram_bytes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['owner'] = this.owner;
    data['net_weight'] = this.netWeight;
    data['cpu_weight'] = this.cpuWeight;
    data['ram_bytes'] = this.ramBytes;
    return data;
  }
}

class SelfDelegatedBandwidth {
  String from;
  String to;
  String netWeight;
  String cpuWeight;

  SelfDelegatedBandwidth({this.from, this.to, this.netWeight, this.cpuWeight});

  SelfDelegatedBandwidth.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    netWeight = json['net_weight'];
    cpuWeight = json['cpu_weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    data['net_weight'] = this.netWeight;
    data['cpu_weight'] = this.cpuWeight;
    return data;
  }
}

class VoterInfo {
  String owner;
  String proxy;
  List<Producers> producers;
  int staked;
  String lastVoteWeight;
  String proxiedVoteWeight;
  int isProxy;
  int reserved1;
  int reserved2;
  String reserved3;

  VoterInfo(
      {this.owner,
      this.proxy,
      this.producers,
      this.staked,
      this.lastVoteWeight,
      this.proxiedVoteWeight,
      this.isProxy,
      this.reserved1,
      this.reserved2,
      this.reserved3});

  VoterInfo.fromJson(Map<String, dynamic> json) {
    owner = json['owner'];
    proxy = json['proxy'];
    if (json['producers'] != null) {
      producers = new List<Producers>();
      json['producers'].forEach((v) {
        producers.add(new Producers.fromJson(v));
      });
    }
    staked = json['staked'];
    lastVoteWeight = json['last_vote_weight'];
    proxiedVoteWeight = json['proxied_vote_weight'];
    isProxy = json['is_proxy'];
    reserved1 = json['reserved1'];
    reserved2 = json['reserved2'];
    reserved3 = json['reserved3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['owner'] = this.owner;
    data['proxy'] = this.proxy;
    if (this.producers != null) {
      data['producers'] = this.producers.map((v) => v.toJson()).toList();
    }
    data['staked'] = this.staked;
    data['last_vote_weight'] = this.lastVoteWeight;
    data['proxied_vote_weight'] = this.proxiedVoteWeight;
    data['is_proxy'] = this.isProxy;
    data['reserved1'] = this.reserved1;
    data['reserved2'] = this.reserved2;
    data['reserved3'] = this.reserved3;
    return data;
  }
}

class Producers {
  String abc;

  Producers({this.abc});

  Producers.fromJson(Map<String, dynamic> json) {
    abc = json['abc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['abc'] = this.abc;
    return data;
  }
}
