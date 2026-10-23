module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<11> : tensor<i8>}> : () -> tensor<i8>
    %1 = "tosa.const"() <{values = dense<-20> : tensor<i8>}> : () -> tensor<i8>
    %2 = "tosa.const"() <{values = dense<1.529100e+02> : tensor<3x9x2x10xf32>}> : () -> tensor<3x9x2x10xf32>
    %3 = "tosa.const"() <{values = dense<-1.116000e+02> : tensor<3x9x41x10xf32>}> : () -> tensor<3x9x41x10xf32>
    %4 = tosa.bitwise_or %0, %1 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %5 = tosa.concat %2, %3 {axis = 2 : i32} : (tensor<3x9x2x10xf32>, tensor<3x9x41x10xf32>) -> tensor<3x9x43x10xf32>
    %6 = tosa.reciprocal %5 : (tensor<3x9x43x10xf32>) -> tensor<3x9x43x10xf32>
    %7 = tosa.reverse %5 {axis = 2 : i32} : (tensor<3x9x43x10xf32>) -> tensor<3x9x43x10xf32>
    %8 = tosa.add %6, %7 : (tensor<3x9x43x10xf32>, tensor<3x9x43x10xf32>) -> tensor<3x9x43x10xf32>
    %cast = tensor.cast %4 : tensor<i8> to tensor<*xi8>
    %cast_0 = tensor.cast %8 : tensor<3x9x43x10xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

