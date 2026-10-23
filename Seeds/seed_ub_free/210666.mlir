module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<195> : tensor<1x8x4x10xi16>}> : () -> tensor<1x8x4x10xi16>
    %1 = tosa.clz %0 : (tensor<1x8x4x10xi16>) -> tensor<1x8x4x10xi16>
    %2 = tosa.reverse %1 {axis = 3 : i32} : (tensor<1x8x4x10xi16>) -> tensor<1x8x4x10xi16>
    %cast = tensor.cast %2 : tensor<1x8x4x10xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

