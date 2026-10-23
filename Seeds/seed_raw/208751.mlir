module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<14> : tensor<1x7x10xi8>}> : () -> tensor<1x7x10xi8>
    %1 = "tosa.const"() <{values = dense<3> : tensor<1x1x1xi8>}> : () -> tensor<1x1x1xi8>
    %2 = "tosa.const"() <{values = dense<-1.681900e+02> : tensor<10x8xf32>}> : () -> tensor<10x8xf32>
    %3 = tosa.add %0, %1 : (tensor<1x7x10xi8>, tensor<1x1x1xi8>) -> tensor<1x7x10xi8>
    %4 = tosa.reduce_sum %3 {axis = 1 : i32} : (tensor<1x7x10xi8>) -> tensor<1x1x10xi8>
    %5 = tosa.abs %4 : (tensor<1x1x10xi8>) -> tensor<1x1x10xi8>
    %6 = tosa.reduce_sum %5 {axis = 1 : i32} : (tensor<1x1x10xi8>) -> tensor<1x1x10xi8>
    %7 = tosa.reduce_min %6 {axis = 0 : i32} : (tensor<1x1x10xi8>) -> tensor<1x1x10xi8>
    %8 = tosa.log %2 : (tensor<10x8xf32>) -> tensor<10x8xf32>
    %9 = tosa.rsqrt %8 : (tensor<10x8xf32>) -> tensor<10x8xf32>
    %cast = tensor.cast %7 : tensor<1x1x10xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %9 : tensor<10x8xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

