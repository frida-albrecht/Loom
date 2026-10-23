module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<140> : tensor<4xi16>}> : () -> tensor<4xi16>
    %1 = tosa.bitwise_not %0 : (tensor<4xi16>) -> tensor<4xi16>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = tosa.transpose %1 {perms = array<i32: 0>} : (tensor<4xi16>) -> tensor<4xi16>
    %cast = tensor.cast %3 : tensor<4xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

