module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<13> : tensor<i8>}> : () -> tensor<i8>
    %1 = "tosa.const"() <{values = dense<false> : tensor<1x4x10x10xi1>}> : () -> tensor<1x4x10x10xi1>
    %2 = "tosa.const"() <{values = dense<1.834300e+02> : tensor<9xf32>}> : () -> tensor<9xf32>
    %3 = tosa.identity %0 : (tensor<i8>) -> tensor<i8>
    %4 = tosa.abs %3 : (tensor<i8>) -> tensor<i8>
    %5 = tosa.argmax %1 {axis = 1 : i32} : (tensor<1x4x10x10xi1>) -> tensor<1x10x10xi32>
    %6 = tosa.sigmoid %2 : (tensor<9xf32>) -> tensor<9xf32>
    %7 = tosa.reduce_min %6 {axis = 0 : i32} : (tensor<9xf32>) -> tensor<1xf32>
    %cast = tensor.cast %4 : tensor<i8> to tensor<*xi8>
    %cast_0 = tensor.cast %5 : tensor<1x10x10xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %7 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

