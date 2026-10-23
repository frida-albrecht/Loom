module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<49> : tensor<6x1x6xi16>}> : () -> tensor<6x1x6xi16>
    %1 = "tosa.const"() <{values = dense<158> : tensor<1x1x6xi16>}> : () -> tensor<1x1x6xi16>
    %2 = tosa.sub %0, %1 : (tensor<6x1x6xi16>, tensor<1x1x6xi16>) -> tensor<6x1x6xi16>
    %3 = tosa.reduce_min %2 {axis = 1 : i32} : (tensor<6x1x6xi16>) -> tensor<6x1x6xi16>
    %4 = tosa.reduce_sum %3 {axis = 1 : i32} : (tensor<6x1x6xi16>) -> tensor<6x1x6xi16>
    %cast = tensor.cast %4 : tensor<6x1x6xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

