#!/usr/bin/env python3

from pathlib import Path


BASE_WORDS = [
    "account",
    "address",
    "admin",
    "application",
    "appointment",
    "asset",
    "attachment",
    "author",
    "booking",
    "cart",
    "case",
    "category",
    "channel",
    "client",
    "comment",
    "company",
    "contact",
    "contract",
    "conversation",
    "coupon",
    "credential",
    "customer",
    "department",
    "device",
    "document",
    "download",
    "employee",
    "event",
    "export",
    "feed",
    "file",
    "folder",
    "form",
    "friend",
    "group",
    "history",
    "image",
    "import",
    "integration",
    "invoice",
    "item",
    "job",
    "key",
    "license",
    "location",
    "log",
    "media",
    "member",
    "message",
    "notification",
    "note",
    "object",
    "offer",
    "order",
    "organization",
    "owner",
    "payment",
    "permission",
    "post",
    "product",
    "profile",
    "project",
    "receipt",
    "record",
    "refund",
    "report",
    "request",
    "reservation",
    "resource",
    "role",
    "rule",
    "service",
    "session",
    "setting",
    "share",
    "site",
    "subscription",
    "task",
    "team",
    "template",
    "tenant",
    "thread",
    "ticket",
    "token",
    "transaction",
    "upload",
    "user",
    "wallet",
    "webhook",
    "workspace",
]

ID_SUFFIXES = [
    "id",
    "Id",
    "ID",
    "_id",
    "_Id",
    "_ID",
    "-id",
    "-Id",
    "-ID",
]

REFERENCE_SUFFIXES = [
    "uuid",
    "Uuid",
    "UUID",
    "_uuid",
    "_Uuid",
    "_UUID",
    "key",
    "Key",
    "_key",
    "_Key",
    "ref",
    "Ref",
    "_ref",
    "_Ref",
    "reference",
    "Reference",
    "_reference",
    "_Reference",
]


def generate_variants(word: str) -> set[str]:
    variants = {
        word,
        word.lower(),
        word.upper(),
        word.capitalize(),
    }

    for suffix in ID_SUFFIXES:
        variants.add(f"{word}{suffix}")

    for suffix in REFERENCE_SUFFIXES:
        variants.add(f"{word}{suffix}")

    return variants


def main() -> None:
    project_root = Path(__file__).resolve().parent.parent
    output_file = project_root / "wordlists" / "idor" / "generated-parameters.txt"

    output_file.parent.mkdir(parents=True, exist_ok=True)

    entries: set[str] = set()

    for word in BASE_WORDS:
        entries.update(generate_variants(word))

    sorted_entries = sorted(entries, key=lambda value: (value.lower(), value))

    output_file.write_text(
        "\n".join(sorted_entries) + "\n",
        encoding="utf-8",
    )

    print(f"[+] Generated file: {output_file}")
    print(f"[+] Unique entries: {len(sorted_entries)}")


if __name__ == "__main__":
    main()
