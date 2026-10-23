module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1> : tensor<i8>}> : () -> tensor<i8>
    %1 = "tosa.const"() <{values = dense<-14> : tensor<i8>}> : () -> tensor<i8>
    %2 = "tosa.const"() <{values = dense<189> : tensor<2x5x10xi32>}> : () -> tensor<2x5x10xi32>
    %3 = "tosa.const"() <{values = dense<-102> : tensor<1x5x1xi32>}> : () -> tensor<1x5x1xi32>
    %4 = tosa.arithmetic_right_shift %0, %1 {round = false} : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %5 = tosa.clz %4 : (tensor<i8>) -> tensor<i8>
    %6 = tosa.intdiv %2, %3 : (tensor<2x5x10xi32>, tensor<1x5x1xi32>) -> tensor<2x5x10xi32>
    %7 = tosa.reverse %6 {axis = 1 : i32} : (tensor<2x5x10xi32>) -> tensor<2x5x10xi32>
    %cast = tensor.cast %5 : tensor<i8> to tensor<*xi8>
    %cast_0 = tensor.cast %7 : tensor<2x5x10xi32> to tensor<*xi32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

