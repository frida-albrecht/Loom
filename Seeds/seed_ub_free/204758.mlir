module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-14> : tensor<4xi8>}> : () -> tensor<4xi8>
    %1 = "tosa.const"() <{values = dense<20> : tensor<4xi8>}> : () -> tensor<4xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<4xi8>}> : () -> tensor<4xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<4xi8>}> : () -> tensor<4xi8>
    %a1 = tosa.maximum %1, %c0 : (tensor<4xi8>, tensor<4xi8>) -> tensor<4xi8>
    %a2 = tosa.minimum %a1, %c7 : (tensor<4xi8>, tensor<4xi8>) -> tensor<4xi8>
    %2 = tosa.arithmetic_right_shift %0, %a2 {round = false} : (tensor<4xi8>, tensor<4xi8>) -> tensor<4xi8>
    %3 = tosa.reduce_min %2 {axis = 0 : i32} : (tensor<4xi8>) -> tensor<1xi8>
    %4 = tosa.argmax %3 {axis = 0 : i32} : (tensor<1xi8>) -> tensor<i32>
    %5 = tosa.reverse %2 {axis = 0 : i32} : (tensor<4xi8>) -> tensor<4xi8>
    %6 = tosa.bitwise_not %4 : (tensor<i32>) -> tensor<i32>
    %7 = tosa.reduce_product %5 {axis = 0 : i32} : (tensor<4xi8>) -> tensor<1xi8>
    %8 = tosa.bitwise_or %6, %6 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %7 : tensor<1xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %8 : tensor<i32> to tensor<*xi32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}