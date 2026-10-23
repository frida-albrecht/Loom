module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-141> : tensor<6x9x6xi16>}> : () -> tensor<6x9x6xi16>
    %1 = "tosa.const"() <{values = dense<168> : tensor<6x1x6xi16>}> : () -> tensor<6x1x6xi16>
    %2 = "tosa.const"() <{values = dense<-133> : tensor<6x4x10xi32>}> : () -> tensor<6x4x10xi32>
    %3 = "tosa.const"() <{values = dense<104> : tensor<6x4x1xi32>}> : () -> tensor<6x4x1xi32>
    %4 = tosa.arithmetic_right_shift %0, %1 {round = true} : (tensor<6x9x6xi16>, tensor<6x1x6xi16>) -> tensor<6x9x6xi16>
    %5 = tosa.minimum %2, %3 : (tensor<6x4x10xi32>, tensor<6x4x1xi32>) -> tensor<6x4x10xi32>
    %cast = tensor.cast %4 : tensor<6x9x6xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %5 : tensor<6x4x10xi32> to tensor<*xi32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

