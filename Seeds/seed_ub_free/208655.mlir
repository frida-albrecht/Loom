module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-45> : tensor<2x8x4xi16>}> : () -> tensor<2x8x4xi16>
    %1 = "tosa.const"() <{values = dense<176> : tensor<2x4x10xi16>}> : () -> tensor<2x4x10xi16>
    %2 = "tosa.const"() <{values = dense<-125> : tensor<6x2x4xi64>}> : () -> tensor<6x2x4xi64>
    %3 = "tosa.const"() <{values = dense<-22> : tensor<6x2x4xi64>}> : () -> tensor<6x2x4xi64>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %6 = tosa.matmul %0, %1, %4, %5 : (tensor<2x8x4xi16>, tensor<2x4x10xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<2x8x10xi16>
    %7 = tosa.minimum %2, %3 : (tensor<6x2x4xi64>, tensor<6x2x4xi64>) -> tensor<6x2x4xi64>
    // Undefined Behavior: tosa.logical_left_shift requires 0 <= value2 <= 63 for i64.
    // The second operand (%7) has values dense<-125>, which is less than 0.
    // Fix: Clamp %7 to be within [0, 63] before using it as the shift amount.
    %c0 = "tosa.const"() <{values = dense<0> : tensor<6x2x4xi64>}> : () -> tensor<6x2x4xi64>
    %a1 = tosa.maximum %7, %c0 : (tensor<6x2x4xi64>, tensor<6x2x4xi64>) -> tensor<6x2x4xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<6x2x4xi64>}> : () -> tensor<6x2x4xi64>
    %a2 = tosa.minimum %a1, %c63 : (tensor<6x2x4xi64>, tensor<6x2x4xi64>) -> tensor<6x2x4xi64>
    %8 = tosa.logical_left_shift %7, %a2 : (tensor<6x2x4xi64>, tensor<6x2x4xi64>) -> tensor<6x2x4xi64>
    %9 = tosa.add %6, %6 : (tensor<2x8x10xi16>, tensor<2x8x10xi16>) -> tensor<2x8x10xi16>
    %cast = tensor.cast %8 : tensor<6x2x4xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %9 : tensor<2x8x10xi16> to tensor<*xi16>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}