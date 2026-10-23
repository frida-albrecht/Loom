module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-168> : tensor<3x4x10xi16>}> : () -> tensor<3x4x10xi16>
    %1 = "tosa.const"() <{values = dense<147> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<-144> : tensor<i32>}> : () -> tensor<i32>
    %3 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<3x4x10xi16>) -> tensor<1x4x10xi16>
    %c1 = "tosa.const"() <{values = dense<0> : tensor<1x4x10xi16>}> : () -> tensor<1x4x10xi16>
    %c2 = "tosa.const"() <{values = dense<15> : tensor<1x4x10xi16>}> : () -> tensor<1x4x10xi16>
    %v1 = tosa.maximum %3, %c1 : (tensor<1x4x10xi16>, tensor<1x4x10xi16>) -> tensor<1x4x10xi16>
    %v2 = tosa.minimum %v1, %c2 : (tensor<1x4x10xi16>, tensor<1x4x10xi16>) -> tensor<1x4x10xi16>
    %4 = tosa.arithmetic_right_shift %3, %v2 {round = false} : (tensor<1x4x10xi16>, tensor<1x4x10xi16>) -> tensor<1x4x10xi16>
    %5 = tosa.intdiv %1, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %4 : tensor<1x4x10xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %5 : tensor<i32> to tensor<*xi32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}