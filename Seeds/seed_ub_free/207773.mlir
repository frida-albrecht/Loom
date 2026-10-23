module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<169> : tensor<3xi16>}> : () -> tensor<3xi16>
    %1 = tosa.clamp %0 {max_val = 86 : i16, min_val = 4 : i16} : (tensor<3xi16>) -> tensor<3xi16>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = tosa.negate %1, %2, %3 : (tensor<3xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<3xi16>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %6 = tosa.transpose %4 {perms = array<i32: 0>} : (tensor<3xi16>) -> tensor<3xi16>
    %cast = tensor.cast %6 : tensor<3xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

